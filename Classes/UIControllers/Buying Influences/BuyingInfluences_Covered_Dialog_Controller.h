//
//  BuyingInfluences_Covered_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextField.h"
#import "WSListPickerController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"
#import "BSInfluence.h"
#import "WSEditDialogController.h"

@interface BuyingInfluences_Covered_Dialog_Controller : WSEditDialogController {
	IBOutlet WSTextView *description;
	WSTextViewController *description_Controller;
	IBOutlet WSTextField *rating;
	WSListPickerController *rating_Controller;
	BSInfluence *influence;
}
@property(nonatomic, retain)BSInfluence *influence;
@property(nonatomic, retain)IBOutlet WSTextView *description;
@property(nonatomic, retain)WSTextViewController *description_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *rating;
@property(nonatomic, retain)WSListPickerController *rating_Controller;
@end
