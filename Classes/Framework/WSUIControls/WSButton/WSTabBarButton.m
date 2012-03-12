//
//  WSTabBarButton.m
//  CRMSync
//
//  Created by Toby Widdowson on 04/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTabBarButton.h"
#import "WSUtils.h"
#import "WSStyle.h"

@implementation WSTabBarButton
@synthesize lblHeight;
-(void)additionalSetup{
}
-(void)buildLabel{	
	lblHeight = 15;
	self.label = [[WSLabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - lblHeight, self.frame.size.width, lblHeight)];
	[self addSubview:label];
	label.hidden = YES;
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor clearColor];
	label.opaque = NO;
	label.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnFGHex]];
	self.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnBGHex]];
}
-(void)buildImageView{
	self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width / 2) - (imageView.frame.size.width / 2), 10, 32, 32)];
	imageView.image = image;
	if(image != nil){
		imageView.frame = CGRectMake((self.frame.size.width / 2) - (imageView.frame.size.width / 2), 10, 32, 32);
	}
	[self addSubview:imageView];
	imageView.opaque = NO;
	imageView.backgroundColor = [UIColor clearColor];
}

-(void)setButtonFrame:(CGRect)newFrame{
	self.frame = newFrame;
	label.frame = CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 2, newFrame.size.width, 20);
	highlight.frame = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
	[self centerImage];
}

- (void)dealloc {
    [super dealloc];
}


@end
