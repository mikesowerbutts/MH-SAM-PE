//
//  BSDragDrop.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 17/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "BSDragDrop.h"


@implementation BSDragDrop
@synthesize barbell_Btn, barbell_Controller, flag_Btn, flag_Controller, eraser_Btn, eraser_Controller, delegate;
-(id)init{
	self.backgroundColor = [UIColor clearColor];
	CGRect dragRect = CGRectMake(0, 0, 1024, 768);
	int padding = 5;
	float xOffset = 0;
	float yOffset = 0;
	UIImage *barbell_Img = [UIImage imageNamed:@"barbell.png"];
	CGRect barbell_Rect = CGRectMake(xOffset, yOffset + (self.frame.size.height / 2) - (barbell_Img.size.height / 2), barbell_Img.size.width, barbell_Img.size.height);
	self.barbell_Btn = [[WSDraggableButton alloc] initWithFrame:barbell_Rect];
	self.barbell_Btn.imageView.image = barbell_Img;
	self.barbell_Btn.highlight.hidden = YES;
	[self addSubview:self.barbell_Btn];
	self.barbell_Controller = [[MHFlagButtonController alloc] initWithButtonViewAndRect:self.barbell_Btn containerView:self.superview dragRect:dragRect ID:[self.delegate ID]];
	self.barbell_Controller.hideWhenCopying = NO;
	self.barbell_Controller.type = @"barbell";
	
	UIImage *flag_Img = [UIImage imageNamed:@"redflag.png"];
	CGRect flag_Rect = CGRectMake(xOffset + barbell_Img.size.width + padding, yOffset + (self.frame.size.height / 2) - (flag_Img.size.height / 2), flag_Img.size.width, flag_Img.size.height);
	self.flag_Btn = [[[WSDraggableButton alloc] initWithFrame:flag_Rect] autorelease];//Leak
	self.flag_Btn.imageView.image = flag_Img;
	self.flag_Btn.highlight.hidden = YES;
	[self addSubview:self.flag_Btn];
	self.flag_Controller = [[MHFlagButtonController alloc] initWithButtonViewAndRect:self.flag_Btn containerView:self.superview dragRect:dragRect ID:[self.delegate ID]];
	self.flag_Controller.hideWhenCopying = NO;
	self.flag_Controller.type = @"redflag";
	
	UIImage *eraser_Img = [UIImage imageNamed:@"eraser.png"];
	CGRect eraser_Rect = CGRectMake(xOffset + barbell_Img.size.width + flag_Img.size.width + (padding * 2), yOffset + (self.frame.size.height / 2) - (eraser_Img.size.height / 2), eraser_Img.size.width, eraser_Img.size.height);
	self.eraser_Btn = [[WSDraggableButton alloc] initWithFrame:eraser_Rect];
	self.eraser_Btn.imageView.image = eraser_Img;
	self.eraser_Btn.highlight.hidden = YES;
	[self addSubview:self.eraser_Btn];
	self.eraser_Controller = [[[MHFlagButtonController alloc] initWithButtonViewAndRect:self.eraser_Btn containerView:self.superview dragRect:dragRect ID:[self.delegate ID]] autorelease];//Leak
	self.eraser_Controller.hideWhenCopying = NO;
	self.eraser_Controller.type = @"eraser";
	return self;
}
-(void)dealloc{
    [barbell_Btn release];
    [barbell_Controller release];
    [flag_Btn release];
    [flag_Controller release];
    [eraser_Btn release];
    [eraser_Controller release];
    delegate = nil;
    [super dealloc];
}
@end
