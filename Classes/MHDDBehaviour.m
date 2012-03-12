//
//  MHDDBehaviour.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 25/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHDDBehaviour.h"


@implementation MHDDBehaviour
-(void)checkFlag:(NSString *)theFlagID{
	self.flagID = theFlagID;
	BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[[self.delegate delegate] ID]];
	BSDragObject *d = [dm.flagsList getObjectByID:self.flagID];
	if(d != nil){
		CGPoint center = CGPointMake(self.frame.size.width * [d.xRatio floatValue], self.frame.size.height * [d.yRatio floatValue]);
		UIImage *img = [UIImage imageNamed:[d getImage]];
		WSDraggableButton *flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		flagBtn.imageView.image = img;
		flagBtn.highlight.hidden = YES;
		flagBtn.center = center;
		flagBtn.tag = d.type;
		self.flagController = [[MHFlagButtonController alloc] initWithButtonViewAndRect:flagBtn containerView:self.superview dragRect:CGRectMake(0, 0, 1024, 768) ID:@""];
		flagController.isOwned = YES;
		flagController.hideWhenCopying = YES;
		[self addSubview:self.flagController.dragBtn];
		[self bringSubviewToFront:self.flagController.dragBtn];
	}
}
-(void)flagDropped:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if(self.flagController == dbc){
		if(!self.flagController.isOwned){
			self.flagController = nil;
			[self.flagController dealloc];
		}
		else {
			CGPoint pt =  [self convertPoint:self.flagController.theCopy.center fromView:self.flagController.theCopy.superview];
			[dbc.theCopy removeFromSuperview];
			self.flagController = [dbc copy];
			self.flagController.hideWhenCopying = YES;			
			[self addSubview:self.flagController.dragBtn];
			[self bringSubviewToFront:self.flagController.dragBtn];
			self.flagController.dragBtn.hidden = NO;
			self.flagController.dragBtn.center = pt;
			self.flagController.dragBtn.highlight.hidden = YES;
		}
	}
}
-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	CGRect fr = dbc.theCopy.frame;
	CGRect inter = CGRectIntersection(self.frame, fr);
	if(inter.size.height > (fr.size.height / 2) && inter.size.width > (fr.size.width / 2)){
		if(self.flagID != nil && (self.flagController == nil || dbc == self.flagController)){
			if(self.flagController == nil){
				self.flagController = dbc;
			}
			self.flagController.noDropImg.hidden = YES;
			self.flagController.isOwned = YES;
		}
	}
	else {
		if(self.flagID != nil && self.flagController == dbc){
			self.flagController.noDropImg.hidden = NO;
			self.flagController.isOwned = NO;
		}
	}
}

@end
