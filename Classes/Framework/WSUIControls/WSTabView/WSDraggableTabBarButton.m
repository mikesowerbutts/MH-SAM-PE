//
//  WSraggableTabBarButton.m
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDraggableTabBarButton.h"


@implementation WSDraggableTabBarButton
@synthesize appletContainer;
-(void)additionalSetup{
	NSLog(@"additionalSetup");
	self.appletContainer = [[WSAppletContainer alloc] initWithFrameAndApplet:CGRectMake(0, 0, 0, 768) applet:nil];
	label.transform = CGAffineTransformMakeRotation(M_PI/2);
	label.numberOfLines = 2;
}
-(void)setButtonFrame:(CGRect)newFrame{
	self.frame = newFrame;
	label.frame = CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 2, newFrame.size.width, newFrame.size.height - (imageView.frame.origin.x + imageView.frame.size.height + 3));
	highlight.frame = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
	[self centerImage];
}
@end
