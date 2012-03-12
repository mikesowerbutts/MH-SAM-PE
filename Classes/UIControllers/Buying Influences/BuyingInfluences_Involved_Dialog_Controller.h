//
//  BuyingInfluences_Involved_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSEditDialogController.h"
#import "WSListPickerController.h"
#import "WSContactListPickerController.h"
#import "WSTextField.h"
#import "WSTextFieldController.h"
#import "BSInfluence.h"

@interface BuyingInfluences_Involved_Dialog_Controller : WSEditDialogController {
	IBOutlet WSTextField *nameField;
	WSContactListPickerController *nameField_Controller;
	IBOutlet WSTextField *rolesField;
	WSListPickerController *rolesField_Controller;
	IBOutlet WSTextField *degreeField;
	WSListPickerController *degreeField_Controller;
	IBOutlet WSTextField *modeField;
	WSListPickerController *modeField_Controller;
	BSInfluence *influence;
}
@property(nonatomic, retain)BSInfluence *influence;

@property(nonatomic, retain)IBOutlet WSTextField *nameField;
@property(nonatomic, retain)IBOutlet WSTextField *rolesField;
@property(nonatomic, retain)IBOutlet WSTextField *degreeField;
@property(nonatomic, retain)IBOutlet WSTextField *modeField;

@property(nonatomic, retain)WSContactListPickerController *nameField_Controller;
@property(nonatomic, retain)WSListPickerController *rolesField_Controller;
@property(nonatomic, retain)WSListPickerController *degreeField_Controller;
@property(nonatomic, retain)WSListPickerController *modeField_Controller;
@end
