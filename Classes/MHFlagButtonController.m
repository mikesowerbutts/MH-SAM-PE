//
//  MHFlagButtonController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHFlagButtonController.h"
#import "BlueSheetDataModel.h"

@implementation MHFlagButtonController
@synthesize theCopy, owner, hideWhenCopying, hasBeenDragged, type, dragObj, hasBeenReleased, magController, appletContainerIsFS;
-(id)initWithButtonViewAndRect:(WSDraggableButton *)theButton containerView:(UIView *)theContainerView dragRect:(CGRect)theDragRect ID:(NSString *)theID{
	[super initWithButtonViewAndRect:theButton containerView:theContainerView dragRect:theDragRect ID:theID];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagErased:) name:@"MHFlagErased" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appletContainerFullscreenChanged:) name:@"appletContainerFullscreenChanged" object:nil];
	self.dragBtn.delegate = self;
	self.dragBtn.frame = CGRectMake(self.dragBtn.frame.origin.x - (self.dragBtn.imageView.image.size.width * 0.5), self.dragBtn.frame.origin.y, self.dragBtn.imageView.image.size.width * 2, self.dragBtn.frame.size.height);
	return self;
}
-(void)appletContainerFullscreenChanged:(NSNotification *)notification{
    self.appletContainerIsFS = [notification object] == @"YES" ? YES : NO;
}
-(void)flagErased:(NSNotification *)notification{
	if(self.magController != nil){
		[self.magController refreshScreen];
    }
}
-(void)draggedOut:(UIControl *)control withEvent:(UIEvent *)event {
	[self hasBeenDraggedOut:[[[event allTouches] anyObject] locationInView:self.containerView]];
}
-(void)hasBeenDraggedOut:(CGPoint)pt{
	if(CGRectContainsPoint(CGRectMake(pt.x - 50, pt.y - 50, 100, 100), pt)){
		self.hasBeenDragged = YES;
		if(magController == nil){
			if(self.hideWhenCopying)
				self.dragBtn.hidden = YES;
			if(self.hideWhenCopying || [self.type isEqualToString:@"eraser"]){
				self.dragBtn.hidden = NO;
			}
		}
		if(self.theCopy == nil){
			self.theCopy = [dragBtn copy];
			if(hideWhenCopying)
				self.dragBtn.hidden = YES;
		}
		self.theCopy.center = pt;
		self.theCopy.hidden = YES;
		[self.magController setMagLoc:pt];
		self.theCopy.hidden = NO;
		if(self.theCopy.superview == nil)
			[self.containerView addSubview:self.theCopy];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagDragging" object:self];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"MHDisableTables" object:nil];
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.magController == nil){
        self.magController = [[WSMagnifyingGlassController alloc] initWithViewAndIcon:self.containerView iconFile:[NSString stringWithFormat:@"%@.png", self.type]];
        if(self.hideWhenCopying)
            self.magController.red.hidden = YES;
        [self.magController setMagLoc:[self.containerView convertPoint:self.dragBtn.center fromView:self.dragBtn.superview]];
    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(alertView.tag == 1){
		if(buttonIndex == 1)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MakeFullScreen" object:ID];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    @try{
    [self.magController release];
    [self.magController removeViews];
    self.magController = nil;
	if(hasBeenDragged){
		self.hasBeenDragged = NO;
		if(self.hideWhenCopying)
			[self.dragBtn removeFromSuperview];
		if(self.owner == nil){
			if(([self.type isEqualToString:@"redflag"] || [self.type isEqualToString:@"barbell"]) && self.hideWhenCopying){
				[dragBtn removeFromSuperview];
				BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
				[dm.flagsList removeObjectByID:self.dragObj.ID];
			}
			if(self.hideWhenCopying){
				[self release];
				self.hasBeenReleased = YES;
			}
			[theCopy removeFromSuperview];
			self.theCopy = nil;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagDestroyed" object:self];
		}
		else
			[[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagDropped" object:self];
	}
	[[NSNotificationCenter defaultCenter] postNotificationName:@"MHEnableTables" object:nil];
    }
    @catch (NSException *ex) {
        NSLog(@"Error on flag touches ended: %@", ex.reason);
    }
}
-(id)copyWithZone:(NSZone *)zone{
	MHFlagButtonController *aCopy = [[[self class] allocWithZone:zone] initWithButtonViewAndRect:[self.dragBtn copy] containerView:self.containerView dragRect:self.dragRect ID:[self.ID copy]];
	aCopy.owner = self.owner;
	aCopy.hideWhenCopying = self.hideWhenCopying;
	aCopy.hasBeenDragged = self.hasBeenDragged;
	aCopy.type = [[self.type copy] autorelease];
	aCopy.dragObj = [[self.dragObj copy] autorelease];
    aCopy.appletContainerIsFS = self.appletContainerIsFS;
	return aCopy;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [dragBtn release];
	[theCopy release];
	[super dealloc];
}
@end
