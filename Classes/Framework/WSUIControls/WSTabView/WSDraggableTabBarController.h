//
//  WSDraggableTabController.h
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTabBarController.h"
#import "WSDraggableTabBarButtonController.h"

@interface WSDraggableTabBarController : WSTabBarController {
	NSString *attachedToSide;
}
@property(nonatomic, retain)NSString *attachedToSide;
@end
