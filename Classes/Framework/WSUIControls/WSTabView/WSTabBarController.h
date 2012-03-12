//
//  WSTabBar.h
//  CRMSync
//
//  Created by Toby Widdowson on 29/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTabBarButton.h"
#import "WSTabBarButtonController.h"
#import "WSTableViewController.h"

@interface WSTabBarController : UIViewController {
	NSMutableArray *loadControllers;
	NSInteger tabBarHeight;
	WSTabBarButtonController *selectedBtn_Controller;
	CGRect buttonsRect;
	CGRect contentRect;
}
@property(nonatomic, retain)NSMutableArray *loadControllers;
@property(nonatomic)NSInteger tabBarHeight;
@property(nonatomic, retain)WSTabBarButtonController *selectedBtn_Controller;
@property(nonatomic)CGRect buttonsRect;
@property(nonatomic)CGRect contentRect;

-(void)addTabItem:(NSString *)tabText imageFile:(NSString *)imageFile viewController:(UIViewController *)viewController;
-(void)positionTabBarItems;
-(BOOL)findVC:(NSNotification *)notification;
-(void)removeAll;
-(void)selTab:(WSButtonController *)btnController;
@end
