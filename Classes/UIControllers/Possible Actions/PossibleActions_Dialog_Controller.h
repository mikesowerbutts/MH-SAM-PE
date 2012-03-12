//
//  PossibleActions_Dialog.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 21/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSEditDialogController.h"
#import "WSListPickerController.h"
#import "WSContactListPickerController.h"
#import "WSTextField.h"
#import "WSTextViewController.h"
#import "WSDateFieldController.h"
#import "WSButton.h"
#import "WSToggleButtonController.h"
#import "WSAction.h"

@interface PossibleActions_Dialog_Controller : WSEditDialogController {
	IBOutlet WSTextView *description;
	WSTextViewController *description_Controller;
	IBOutlet WSTextField *contact;
	WSContactListPickerController *contact_Controller;
	IBOutlet WSTextField *when;
	WSDateFieldController *when_Controller;
	IBOutlet WSTextField *assignedTo;
	WSContactListPickerController *assignedTo_Controller;
	IBOutlet WSTextField *completed;
	WSDateFieldController *completed_Controller;
	IBOutlet WSTextField *status;
	WSListPickerController *status_Controller;
	IBOutlet WSTextField *type;
	WSListPickerController *type_Controller;
	IBOutlet WSButton *bestAction;
	WSToggleButtonController *bestAction_Controller;
	WSAction *action;
}
@property(nonatomic, retain)IBOutlet WSTextView *description;
@property(nonatomic, retain)WSTextViewController *description_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *contact;
@property(nonatomic, retain)WSContactListPickerController *contact_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *when;
@property(nonatomic, retain)WSDateFieldController *when_Controller;

@property(nonatomic, retain)IBOutlet WSTextField *assignedTo;
@property(nonatomic, retain)WSContactListPickerController *assignedTo_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *completed;
@property(nonatomic, retain)WSDateFieldController *completed_Controller;

@property(nonatomic, retain)IBOutlet WSTextField *status;
@property(nonatomic, retain)WSListPickerController *status_Controller;

@property(nonatomic, retain)IBOutlet WSTextField *type;
@property(nonatomic, retain)WSListPickerController *type_Controller;
@property(nonatomic, retain)IBOutlet WSButton *bestAction;
@property(nonatomic, retain)WSToggleButtonController *bestAction_Controller;

@property(nonatomic, retain)WSAction *action;

@end
