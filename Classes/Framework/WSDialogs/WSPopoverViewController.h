//
//  WSPopoverViewController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 05/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSButton.h"
#import "WSButtonController.h"
#import "WSAppViewController.h"

@interface WSPopoverViewController : WSAppViewController<UIPopoverControllerDelegate> {
	UIViewController* popoverContent;
	UIPopoverController* popoverController;
	CGRect dispRect;
	UIView *dispView;
	WSButton *cancelBtn;
	WSButton *okBtn;
	WSButtonController *cancelBtn_Controller;
	WSButtonController *okBtn_Controller;
	BOOL result;
	UIView *dialogView;
}
@property(nonatomic, retain)UIViewController* popoverContent;
@property(nonatomic, retain)UIPopoverController* popoverController;
@property(nonatomic)CGRect dispRect;
@property(nonatomic, retain)UIView *dispView;
@property(nonatomic, retain)WSButtonController *okBtn_Controller;
@property(nonatomic, retain)WSButtonController *cancelBtn_Controller;
@property(nonatomic)BOOL result;
@property(nonatomic, retain)IBOutlet UIView *dialogView;
@property(nonatomic, retain)IBOutlet WSButton *okBtn;
@property(nonatomic, retain)IBOutlet WSButton *cancelBtn;
-(void)init:(UIView *)theDispView displayRect:(CGRect)theDispRect subControls:(NSMutableArray *)subCons;
-(id)initWithSubControls:(UIView *)dispView displayRect:(CGRect)dispRect displaySource:(CGRect)dispSource subControls:(NSMutableArray *)subCons;
-(id)initWithSubControlsDontShow:(UIView *)theDispView displayRect:(CGRect)theDispRect subControls:(NSMutableArray *)subCons;
-(id)initWithXIBDontShow:(NSString *)theNibName mainView:(UIView *)theDispView;
-(void)showPopoverFromRect:(CGRect)sourceRect;
-(void)isClosing:(NSString *)mode;
@end
