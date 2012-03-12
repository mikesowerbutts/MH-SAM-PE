//
//  WSButton.m
//  BlueSheet
//
//  Created by Toby Widdowson on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSButton.h"
#import "WSLabel.h"
#import "WSUtils.h"
#import "WSStyle.h"

@implementation WSButton
@synthesize label, imageView, highlight, image, imageFile, inited, delegate;
-(id)initWithFrame:(CGRect)frame{
	[super initWithFrame:frame];
	[self build:frame];
	[self additionalSetup];
	return self;
}
-(id)initNormal{
	[self build:self.frame];
	[self additionalSetup];
	return self;
}
-(id)initWithFrameAndImageFile:(CGRect)theFrame imageFile:(NSString *)theImageFile{
	self.imageFile = theImageFile;
	[super initWithFrame:theFrame];
	self.image = [UIImage imageNamed:imageFile];
	[self build:self.frame];
	[self additionalSetup];
	return self;
}
-(void)additionalSetup{
	
}
-(void)build:(CGRect)frame{
	self.inited = YES;
	self.backgroundColor = [UIColor clearColor];	
	if(label == nil){
		[self buildLabel];
	}
	if(imageView == nil){
		[self buildImageView];
	}
	if(highlight == nil){
		[self buildHighlight];
	}
}
-(void)buildImageView{
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	imageView.image = image;
	if(image != nil){
		imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
	}
	[self addSubview:imageView];
	imageView.opaque = NO;
	imageView.backgroundColor = [UIColor clearColor];
}
-(void)buildHighlight{
	self.highlight = [[WSButtonHighlight alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	[self addSubview:highlight];
}
-(void)centerImage{
	imageView.frame = CGRectMake((self.frame.size.width / 2) - (self.imageView.frame.size.width / 2), 13, 32, 32);
}
-(void)buildLabel{
	self.label = [[WSLabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	[self addSubview:label];
	label.hidden = YES;
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	label.opaque = NO;
	label.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnFGHex]];
	label.borders = @"TLRB";
	label.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnBGHex]];
}
-(void)setButtonFrame:(CGRect)newFrame{
	NSLog(@"setButtonFrame");
	self.frame = newFrame;
	label.frame = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
	highlight.frame = label.frame;
	[self centerImage];
}
-(void)triggerTouchWithNotification:(NSSet *)touches withEvent:(UIEvent *)event notification:(NSString *)notification{
	[delegate touchUpInside:notification];
}
@end
