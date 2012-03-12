//
//  MHTableLabel.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTableLabel.h"
#import "BSDragObject.h"
#import "BlueSheetDataModel.h"
@implementation MHTableLabel
@synthesize flagID, dmID, flagController, isDragging, addedListeners;
-(void)checkFlag:(NSString *)theFlagID DataModelID:(NSString *)theDmID{
	self.detectDrag = YES;
	self.dmID = theDmID;
    if(!addedListeners){
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDragged:) name:@"MHFlagDragging" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDropped:) name:@"MHFlagDropped" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDestroyed:) name:@"MHFlagDestroyed" object:nil];
        addedListeners = YES;
    }
	self.flagID = theFlagID;
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:dmID];
	BSDragObject *d = (BSDragObject *)[dm.flagsList getObjectByID:self.flagID];
	if(d != nil){
		CGPoint center = CGPointMake(self.frame.size.width * [d.xRatio floatValue], self.frame.size.height * [d.yRatio floatValue]);
		UIImage *img = [UIImage imageNamed:[d getImage]];
		WSDraggableButton *flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		flagBtn.imageView.image = img;
		flagBtn.highlight.hidden = YES;
		flagBtn.center = center;
		self.flagController = [[[MHFlagButtonController alloc] initWithButtonViewAndRect:flagBtn containerView:nil dragRect:CGRectMake(0, 0, 1024, 768) ID:dmID] autorelease];
		flagController.dragObj = d;
		flagController.owner = self;
		self.flagController.type = d.type;
		flagController.hideWhenCopying = YES;
		[self addSubview:self.flagController.dragBtn];
		[self bringSubviewToFront:self.flagController.dragBtn];
	}
}
///*
-(void)flagDropped:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if(dbc.owner == self){
		CGPoint pt = [self convertPoint:dbc.theCopy.center fromView:dbc.containerView];
		pt = CGPointMake(pt.x, self.frame.size.height / 2);
		[dbc.theCopy removeFromSuperview];
		dbc.theCopy = nil;
		self.flagController = [[dbc copy] autorelease];
		self.flagController.hideWhenCopying = YES;			
        CGPoint perPt = [WSUtils PointPercentageInRect:self.frame point:pt];
		BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:dmID];
        [self addSubview:self.flagController.dragBtn];
		[self bringSubviewToFront:self.flagController.dragBtn];
		self.flagController.dragBtn.hidden = NO;
		self.flagController.dragBtn.center = pt;
		self.flagController.dragBtn.highlight.hidden = YES;
		if(self.flagController.dragObj == nil)
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
		else{
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagController.dragObj.ID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
		}
        self.flagController.dragObj.ID = self.flagID;
		[dm.flagsList.items addObject:self.flagController.dragObj];
	}
	else if(dbc == self.flagController){
		[dbc.theCopy removeFromSuperview];
		self.flagController = nil;
		[self.flagController release];
	}
}
-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if([dbc.type isEqualToString:@"redflag"] || [dbc.type isEqualToString:@"barbell"] && (dbc.owner == nil || (MHTableLabel *)dbc.owner == self)){
		CGRect fr = CGRectMake(dbc.theCopy.imageView.frame.origin.x + dbc.theCopy.frame.origin.x, dbc.theCopy.imageView.frame.origin.y + dbc.theCopy.frame.origin.y, dbc.theCopy.imageView.frame.size.width, dbc.theCopy.imageView.frame.size.height);
		CGRect cFr = [dbc.theCopy.superview convertRect:self.frame fromView:self.superview];
		//Dragged in
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6) &&
		   self.flagID != nil && 
		   (dbc.owner == nil || (MHTableLabel *)dbc.owner == self) && 
			(self.flagController == nil || self.flagController == dbc)){
			dbc.magController.red.hidden = YES;
			dbc.owner = (UIControl *)self;
		}
		//Dragged out
		else if(self.flagID != nil && (MHTableLabel *)dbc.owner == self){
			dbc.magController.red.hidden = NO;
			dbc.owner = nil;
		}
	}
	else if([dbc.type isEqualToString:@"eraser"] && self.flagController != nil){
		CGRect fr = dbc.theCopy.frame;
		CGRect cFr = [dbc.theCopy.superview convertRect:self.flagController.dragBtn.frame fromView:self];
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6)){
			BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:self.dmID];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
			[self.flagController.dragBtn removeFromSuperview];
			self.flagController = nil;
            dbc.theCopy.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagErased" object:nil];
            dbc.theCopy.hidden = NO;
		}
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.flagController touchesBegan:touches withEvent:event];
	[self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if(self.flagController != nil){
		CGPoint touchLoc = [[touches anyObject] locationInView:self];
		if(CGRectContainsPoint(self.flagController.dragBtn.frame, touchLoc) || isDragging){
			self.isDragging = YES;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"MHDisableTables" object:nil];
			[self.flagController draggedOut:self.flagController.dragBtn withEvent:event];
		}
	}
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	self.isDragging = NO;
	[self.flagController touchesEnded:touches withEvent:event];
	if(self.flagController.hasBeenReleased)
		self.flagController = nil;
}
-(void)flagDestroyed:(NSNotification *)notification{
	if([notification object] == self.flagController)
		self.flagController = nil;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	[flagID release];
	[dmID release];
	[flagController release];
	[super dealloc];
}
@end
