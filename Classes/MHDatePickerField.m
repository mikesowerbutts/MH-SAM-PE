//
//  MHDatePickerField.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHDatePickerField.h"
#import "BSDragObject.h"
#import "BlueSheetDataModel.h"
@implementation MHDatePickerField
@synthesize flagID, flagBtn, flagController;
-(void)checkFlag:(NSString *)theFlagID{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDragged:) name:@"MHFlagDragging" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDropped:) name:@"MHFlagDropped" object:nil];
	self.flagID = theFlagID;
	BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[[self.delegate delegate] getID]];
	BSDragObject *d = [dm.flagsList getObjectByID:self.flagID];
	if(d != nil){
		CGPoint center = CGPointMake(self.frame.size.width * [d.xRatio floatValue], self.frame.size.height * [d.yRatio floatValue]);
		UIImage *img = [UIImage imageNamed:[d getImage]];
		self.flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		self.flagBtn.imageView.image = img;
		self.flagBtn.highlight.hidden = YES;
		self.flagBtn.center = center;
		self.flagBtn.tag = d.type;
		self.flagController = [[MHFlagButtonController alloc] initWithButtonViewAndRect:self.flagBtn containerView:self.superview dragRect:CGRectMake(0, 0, 1024, 768) ID:@""];
		self.flagController.hideWhenCopying = YES;
		[self addSubview:self.flagBtn];
		[self bringSubviewToFront:self.flagBtn];
	}
}
-(void)flagDropped:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if(self.flagController == dbc){
		self.flagController = dbc;
		CGPoint pt =  [self convertPoint:self.flagController.theCopy.center fromView:self.flagController.theCopy.superview];
		self.flagBtn = self.flagController.dragBtn;
		[self addSubview:self.flagBtn];
		[self bringSubviewToFront:self.flagBtn];
		self.flagBtn.center = pt;
	}
}
-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	CGRect fr = dbc.theCopy.frame;
	CGRect inter = CGRectIntersection(self.frame, fr);
	if(inter.size.height > (fr.size.height / 2) && inter.size.width > (fr.size.width / 2)){
		if(self.flagID != nil && (self.flagController == nil || dbc == self.flagController)){
			self.flagController = dbc;
			self.flagController.noDropImg.hidden = YES;
			self.flagController.isOwned = YES;
		}
	}
	else {
		if(self.flagID != nil && self.flagController == dbc){
			self.flagController.noDropImg.hidden = NO;
			dbc.isOwned = NO;
			self.flagController = nil;
		}
	}
}
@end
