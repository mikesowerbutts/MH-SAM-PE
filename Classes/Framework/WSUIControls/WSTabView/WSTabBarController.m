//
//  WSTabBar.m
//  CRMSync
//
//  Created by Toby Widdowson on 29/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTabBarController.h"


@implementation WSTabBarController
@synthesize loadControllers, tabBarHeight, selectedBtn_Controller, buttonsRect, contentRect;
-(id)initWithFrame:(CGRect)dispRect{
	self = [super init];
	self.view = [[UIView alloc] initWithFrame:dispRect];
	self.tabBarHeight = 70;
	self.loadControllers = [[NSMutableArray alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedTab:) name:@"btnTouchUpInside" object:nil];
	return self;
}
-(void)addTabItem:(NSString *)tabText imageFile:(NSString *)theImageFile viewController:(UIViewController *)viewController{
	WSTabBarButton *btn = [[WSTabBarButton alloc] initWithFrameAndImageFile:CGRectMake(0, 0, tabBarHeight, tabBarHeight) imageFile:theImageFile];
	WSTabBarButtonController *btn_Controller = [[WSTabBarButtonController alloc] initWithButton:btn];
	btn.frame = CGRectMake(0, 0, tabBarHeight, tabBarHeight);
	btn.label.borders = @"";
	btn_Controller.associatedViewController = viewController;
	[btn.label setValue:tabText];
	[self.view addSubview:btn];
	[loadControllers addObject:btn_Controller];
	if([loadControllers count] == 1){
		[self selTab:btn_Controller];
		[btn_Controller toggleSelected];
	}
	else{
		btn_Controller.selected = TRUE;
		[btn_Controller toggleSelected]; 
	}
	[self positionTabBarItems];
	
}
-(void)positionTabBarItems{
	NSInteger itemWid = buttonsRect.size.width / [loadControllers count]; 
	for(int i = 0; i < [loadControllers count]; i++){
		WSTabBarButton *btn = (WSTabBarButton *)[[loadControllers objectAtIndex:i] button];
		[btn setButtonFrame:CGRectMake(buttonsRect.origin.x + (itemWid * i), buttonsRect.origin.y, i < [loadControllers count] - 1 ? itemWid : buttonsRect.size.width - (itemWid * i), btn.frame.size.height)];
	}
}
-(BOOL)findVC:(NSNotification *)notification{
	UIViewController *vc = (UIViewController *)[notification object];
	for(int i = 0; i < [loadControllers count]; i++){
		UIViewController *vc2 = [loadControllers objectAtIndex:i];
		if(vc == vc2){
			return YES;
		}
	}
	return NO;
}
-(void)selectedTab:(NSNotification *)notification{
	if([self findVC:notification]){
		WSTabBarButtonController *btn_Controller = (WSTabBarButtonController *)[notification object];
		[self selTab:btn_Controller];
	}
}
-(void)selTab:(WSTabBarButtonController *)btnController{
	if(selectedBtn_Controller != nil){
		[selectedBtn_Controller.associatedViewController removeAllViews];
		[selectedBtn_Controller toggleSelected];
	}
	[self.view addSubview:btnController.associatedViewController.view];
	WSTableViewController *tbl_Controller = (WSTableViewController *)btnController.associatedViewController;
	tbl_Controller.delegate = self;
	[tbl_Controller setTableViewFrame:contentRect];
	selectedBtn_Controller = btnController;
}
-(void)removeAll{
	for(int i = 0; i < [loadControllers count]; i++){
		[[[loadControllers objectAtIndex:i] button] removeFromSuperview];
	}
	[selectedBtn_Controller.associatedViewController removeAllViews];
	[loadControllers removeAllObjects];
	[self.view removeFromSuperview];
}
@end
