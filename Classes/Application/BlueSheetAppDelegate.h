//
//  BlueSheetAppDelegate.h
//  BlueSheet
//
//  Created by Toby Widdowson on 04/05/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BlueSheetViewController;

@interface BlueSheetAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BlueSheetViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BlueSheetViewController *viewController;

@end

