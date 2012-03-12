//
//  MHFlagButtonController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDraggableButtonController.h"
#import "BSDragObject.h"
#import "WSMagnifyingGlassController.h"
@interface MHFlagButtonController : WSDraggableButtonController<NSCopying> {
	WSDraggableButton *theCopy;
	UIControl *owner;
	BOOL hideWhenCopying;
	BOOL hasBeenDragged;
	NSString *type;
	BSDragObject *dragObj;
	BOOL hasBeenReleased;
	WSMagnifyingGlassController *magController;
    BOOL appletContainerIsFS;
}
@property(nonatomic)BOOL appletContainerIsFS;
@property(nonatomic, retain)WSMagnifyingGlassController *magController;
@property(nonatomic)BOOL hasBeenDragged;
@property(nonatomic)BOOL hasBeenReleased;
@property(nonatomic, assign)UIControl *owner;
@property(nonatomic, retain)BSDragObject *dragObj;
@property(nonatomic, retain)NSString *type;
@property(nonatomic)BOOL hideWhenCopying;
@property(nonatomic, retain)WSDraggableButton *theCopy;

-(id)copyWithZone:(NSZone *)zone;
-(void)hasBeenDraggedOut:(CGPoint)pt;
@end
