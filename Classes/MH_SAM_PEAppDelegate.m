//
//  MH_SAM_PEAppDelegate.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PEAppDelegate.h"
#import "MH_SAM_PEViewController.h"
#import "BlueSheetViewController.h"
#import "WSXMLObject.h"
#import "WSUtils.h"

@implementation MH_SAM_PEAppDelegate
-(void)applicationDidFinishLaunching:(UIApplication *)application{
    @try{
	MH_SAM_PEViewController *bsViewController = [[MH_SAM_PEViewController alloc] initWithNibName:@"WSPE_ViewController" bundle:[NSBundle mainBundle]];
	self.viewController = bsViewController;
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];	
    }
    @catch (NSException *ex) {
        NSLog(@"Error: %@", ex.reason);
    }
}
@end
