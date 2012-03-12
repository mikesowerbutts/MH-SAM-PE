//
//  MH_SAM_PEViewController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPE_ViewController.h"
#import "BlueSheetDataModel.h"
#import "WSProgressBarDialogController.h"
#import "WSURLConnectionManager.h"

@interface MH_SAM_PEViewController : WSPE_ViewController<UIAlertViewDelegate> {
	BlueSheetDataModel *currentDM;
	WSProgressBarDialogController *progressDialog;
    WSCRMOpportunity *activeOpportunity;
    WSURLConnectionManager *connManager;
}
@property(nonatomic, retain)WSURLConnectionManager *connManager;
@property(nonatomic, retain)BlueSheetDataModel *currentDM;
@property(nonatomic, retain)WSProgressBarDialogController *progressDialog;
@property(nonatomic, retain)WSCRMOpportunity *activeOpportunity;

-(BOOL)findAppletByTag:(NSString *)tag;
-(void)closeTheCurrentApplet;
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
-(void)launchOpportunity:(WSCRMOpportunity *)opp;
-(void)checkLaunchOpportunity:(NSNotification *)notification;
@end

