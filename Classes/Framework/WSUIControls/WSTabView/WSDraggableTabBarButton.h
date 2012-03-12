//
//  WSraggableTabBarButton.h
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTabBarButton.h"
#import "WSAppletContainer.h"

@interface WSDraggableTabBarButton : WSTabBarButton {
	WSAppletContainer *appletContainer;
}
@property(nonatomic, retain)WSAppletContainer *appletContainer;
@end
