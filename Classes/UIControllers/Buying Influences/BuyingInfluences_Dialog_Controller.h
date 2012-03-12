//
//  BuyingInfluences_Dialog_Controller.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 06/03/2012.
//  Copyright (c) 2012 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextField.h"
#import "WSListPickerController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"
#import "BSInfluence.h"
#import "WSEditDialogController.h"
#import "WSContactListPickerController.h"
#import "WSTextField.h"
#import "WSTextFieldController.h"

@interface BuyingInfluences_Dialog_Controller : WSEditDialogController{
    BSInfluence *influence;
    
    IBOutlet WSTextField *nameField;
	WSContactListPickerController *nameField_Controller;
	IBOutlet WSTextField *rolesField;
	WSListPickerController *rolesField_Controller;
	IBOutlet WSTextField *degreeField;
	WSListPickerController *degreeField_Controller;
	IBOutlet WSTextField *modeField;
	WSListPickerController *modeField_Controller;
    
    IBOutlet WSTextView *coveredDescription;
	WSTextViewController *coveredDescription_Controller;
	IBOutlet WSTextField *coveredRating;
	WSListPickerController *coveredRating_Controller;
    
    IBOutlet WSTextView *resultDescription;
	WSTextViewController *resultDescription_Controller;
    
    IBOutlet WSButton *saveAndNewBtn;
    WSButtonController *saveAndNewBtn_Controller;
    
    IBOutlet WSLabel *resultHeader;
    IBOutlet WSLabel *coveredHeader;
}
@property(nonatomic, retain)IBOutlet WSLabel *resultHeader;
@property(nonatomic, retain)IBOutlet WSLabel *coveredHeader;
@property(nonatomic, retain)IBOutlet WSButton *saveAndNewBtn;
@property(nonatomic, retain)WSButtonController *saveAndNewBtn_Controller;

@property(nonatomic, retain)BSInfluence *influence;

@property(nonatomic, retain)IBOutlet WSTextField *nameField;
@property(nonatomic, retain)IBOutlet WSTextField *rolesField;
@property(nonatomic, retain)IBOutlet WSTextField *degreeField;
@property(nonatomic, retain)IBOutlet WSTextField *modeField;
@property(nonatomic, retain)WSContactListPickerController *nameField_Controller;
@property(nonatomic, retain)WSListPickerController *rolesField_Controller;
@property(nonatomic, retain)WSListPickerController *degreeField_Controller;
@property(nonatomic, retain)WSListPickerController *modeField_Controller;

@property(nonatomic, retain)IBOutlet WSTextView *coveredDescription;
@property(nonatomic, retain)WSTextViewController *coveredDescription_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *coveredRating;
@property(nonatomic, retain)WSListPickerController *coveredRating_Controller;

@property(nonatomic, retain)IBOutlet WSTextView *resultDescription;
@property(nonatomic, retain)WSTextViewController *resultDescription_Controller;

-(void)saveInfluence;
-(void)setLabels:(WSContact *)con;
-(void)enableControls:(BOOL)enabled;
@end
