//
//  InformationNeeded_Dialog_Controller.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSEditDialogController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"
#import "BSBestInfo.h"
#import "WSListPickerController.h"
#import "WSContactListPickerController.h"
#import "WSDateFieldController.h"
#import "WSToggleButton.h"
#import "WSToggleButtonController.h"

@interface InformationNeeded_Dialog_Controller : WSEditDialogController {
	BSBestInfo *action;
	IBOutlet WSTextView *infoNeeded;
	WSTextViewController *infoNeeded_Controller;
	IBOutlet WSTextView *source;
	WSTextViewController *source_Controller;
	IBOutlet WSTextField *assignedTo;
	WSContactListPickerController *assignedTo_Controller;
	IBOutlet WSTextField *whenAssignedTo;
	WSDateFieldController *whenAssignedTo_Controller;
	IBOutlet WSTextField *contact;
	WSContactListPickerController *contact_Controller;
	IBOutlet WSTextField *whenContact;
	WSDateFieldController *whenContact_Controller;
	IBOutlet WSTextField *status;
	WSListPickerController *status_Controller;
    IBOutlet WSToggleButton *crmActivity;
    WSToggleButtonController *crmActivityController;
}
@property(nonatomic, retain)BSBestInfo *action;
@property(nonatomic, retain)IBOutlet WSTextView *infoNeeded;
@property(nonatomic, retain)WSTextViewController *infoNeeded_Controller;
@property(nonatomic, retain)IBOutlet WSTextView *source;
@property(nonatomic, retain)WSTextViewController *source_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *assignedTo;
@property(nonatomic, retain)WSContactListPickerController *assignedTo_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *whenAssignedTo;
@property(nonatomic, retain)WSDateFieldController *whenAssignedTo_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *contact;
@property(nonatomic, retain)WSContactListPickerController *contact_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *whenContact;
@property(nonatomic, retain)WSDateFieldController *whenContact_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *status;
@property(nonatomic, retain)WSListPickerController *status_Controller;
@property(nonatomic, retain)IBOutlet WSToggleButton *crmActivity;
@property(nonatomic, retain)WSToggleButtonController *crmActivityController;
@end
