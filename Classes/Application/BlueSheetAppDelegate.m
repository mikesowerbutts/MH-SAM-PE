//
//  BlueSheetAppDelegate.m
//  BlueSheet
//
//  Created by Toby Widdowson on 04/05/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import "BlueSheetAppDelegate.h"
#import "BlueSheetViewController.h"
#import "WSUtils.h"

@implementation BlueSheetAppDelegate

@synthesize window;
@synthesize viewController;

-(void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation{
}
-(void)applicationDidFinishLaunching:(UIApplication *)application{
	BlueSheetViewController *bsViewController = [[BlueSheetViewController alloc] initWithNibName:@"BlueSheetView" bundle:[NSBundle mainBundle]];
	viewController = bsViewController;
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];	
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
