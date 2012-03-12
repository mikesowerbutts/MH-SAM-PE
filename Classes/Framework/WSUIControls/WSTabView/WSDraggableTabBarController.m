//
//  WSDraggableTabController.m
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDraggableTabBarController.h"


@implementation WSDraggableTabBarController
@synthesize attachedToSide;
-(id)initWithFrame:(CGRect)dispRect{
	self = [super init];
	self.view = [[UIView alloc] initWithFrame:dispRect];
	self.tabBarHeight = 50;
	self.loadControllers = [[NSMutableArray alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedTab:) name:@"btnTouchUpInside" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resizeView:) name:@"tabDragged" object:nil];
	return self;
}
-(void)resizeView:(NSNotification *)notification{
	WSDraggableTabBarButtonController *btnController = (WSDraggableTabBarButtonController *)[notification object];
	self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, btnController.button.frame.origin.x + btnController.button.frame.size.width, self.view.frame.size.height);
}
-(void)addTabItem:(NSString *)tabText imageFile:(NSString *)theImageFile viewController:(UIViewController *)viewController{
	WSDraggableTabBarButton *btn = [[WSDraggableTabBarButton alloc] initWithFrameAndImageFile:CGRectMake(0,0,tabBarHeight,tabBarHeight) imageFile:theImageFile];
	WSDraggableTabBarButtonController *btn_Controller = [[WSDraggableTabBarButtonController alloc] initWithButton:btn];
	btn.frame = CGRectMake(0, 0, tabBarHeight, tabBarHeight);
	btn_Controller.attachedToSide = attachedToSide;
	btn.label.borders = @"";
	btn_Controller.associatedViewController = viewController;
	[btn.label setValue:tabText];
	[self.view addSubview:btn];
	[self.view addSubview:btn.appletContainer];
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
	NSInteger itemHei = buttonsRect.size.height / [loadControllers count];
	for(int i = 0; i < [loadControllers count]; i++){
		WSDraggableTabBarButton *btn = (WSDraggableTabBarButton *)[[loadControllers objectAtIndex:i] button];
		[btn setButtonFrame:CGRectMake(0, buttonsRect.origin.y + (itemHei * i), btn.frame.size.width, i < [loadControllers count] - 1 ? itemHei : buttonsRect.size.height - (itemHei * i))];
	}
}
-(void)selTab:(WSTabBarButtonController *)btnController{
	if(selectedBtn_Controller != nil){
		//[selectedBtn_Controller.associatedViewController removeAllViews];
		[selectedBtn_Controller toggleSelected];
	}
	//[self.view addSubview:btnController.associatedViewController.view];
	/*
	WSTableViewController *tbl_Controller = (WSTableViewController *)btnController.associatedViewController;
	tbl_Controller.delegate = self;
	[tbl_Controller setTableViewFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - tabBarHeight)];
	*/
	selectedBtn_Controller = btnController;
}
@end
