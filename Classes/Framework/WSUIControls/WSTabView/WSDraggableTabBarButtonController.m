//
//  WSDraggableTabBarButtonController.m
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDraggableTabBarButtonController.h"


@implementation WSDraggableTabBarButtonController
@synthesize appletController, throwTimer, attachedToSide;
-(void)additionalSetup{
	WSDraggableTabBarButton *btn = (WSDraggableTabBarButton *)self.button;
	btn.appletContainer.owningBtn_Controller = self;
	self.appletController = [[WSAppletContainerController alloc] initWithContainerAndXML:[btn appletContainer] xml:nil];
	[btn addTarget:self action:@selector(dragged:withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
	[btn addTarget:self action:@selector(stopDrag:withEvent:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)stopDrag:(WSDraggableTabBarButton *)theBtn withEvent:(UIEvent *)event{
	isDragging = NO;
	[self move:button.frame.origin.x + (button.frame.size.width / 2)];
}

-(void)dragged:(WSDraggableTabBarButton *)theBtn withEvent:(UIEvent *)event{
	NSLog(@"dragged");
	isDragging = YES;
	CGPoint point = ([[[event allTouches] anyObject] locationInView:[self.button superview]]);
	if(point.x - (theBtn.frame.size.width / 2) > -1 && point.x + (theBtn.frame.size.width / 2) < 1025){
		[self move:point.x];
	}
}

-(void)revealBtn{
	if([attachedToSide isEqualToString:@"LEFT"]){
		[self move:1024 - (button.frame.size.width * 2)];
	}
	else if([attachedToSide isEqualToString:@"RIGHT"]){
		[self move:(button.frame.size.width * 2)];
	}
}
																								 
-(void)move:(CGFloat)xPos{
	WSDraggableTabBarButton *btn = (WSDraggableTabBarButton *)self.button;
	btn.frame = CGRectMake(xPos - (btn.frame.size.width / 2), btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
	btn.appletContainer.frame = CGRectMake(0, 0, btn.frame.origin.x, btn.appletContainer.frame.size.height);
	btn.appletContainer.scrollView.frame = btn.appletContainer.frame;
	[[NSNotificationCenter defaultCenter] postNotificationName:@"tabDragged" object:self];
	if([attachedToSide isEqualToString:@"LEFT"] && btn.frame.origin.x < btn.frame.size.width && !isDragging){
		NSLog(@"snap left");
		isDragging = YES;
		[self move:btn.frame.size.width / 2];	
	}
	else if([attachedToSide isEqualToString:@"RIGHT"] && (btn.frame.origin.x + btn.frame.size.width) > (1024 - btn.frame.size.width) && !isDragging){
		NSLog(@"snap right");
		isDragging = YES;
		[self move:1024 - (btn.frame.size.width / 2)];
	}
	if((btn.frame.origin.x + btn.frame.size.width) >= (1024 - btn.frame.size.width) && [attachedToSide isEqualToString:@"LEFT"] && !isDragging){
		NSLog(@"snap offscreen right");
		isDragging = YES;
		[self move:1024 + (btn.frame.size.width / 2)];
	}
	else if(btn.frame.origin.x <= btn.frame.size.width && [attachedToSide isEqualToString:@"RIGHT"] && !isDragging){
		NSLog(@"snap offscreen left");
		isDragging = YES;
		[self move:0 - (btn.frame.size.width / 2)];
	}
}
@end
