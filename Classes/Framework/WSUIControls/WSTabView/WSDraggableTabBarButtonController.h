//
//  WSDraggableTabBarButtonController.h
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTabBarController.h"
#import "WSDraggableTabBarButton.h"
#import "WSAppletContainerController.h"
@interface WSDraggableTabBarButtonController : WSTabBarButtonController {
	WSAppletContainerController *appletController;
	NSTimer *throwTimer;
	int throwCount;
	CGFloat throwVelocity;
	CGFloat dragStartX;
	CGFloat dragDistance;
	CGFloat dragTime;
	CGFloat dragStart;
	CGFloat throwDistance;
	BOOL isDragging;
	NSString *attachedToSide;
}
@property(nonatomic, retain)WSAppletContainerController *appletController;
@property(nonatomic, retain)NSTimer *throwTimer;
@property(nonatomic, retain)NSString *attachedToSide;

//@property(nonatomic)CGFloat dragTime;
//@property(nonatomic)CGFloat dragStart;
-(void)move:(CGFloat)xPos;
-(void)revealBtn;
@end
