//
//  ICP_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 02/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSListPickerController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"
#import "BSCriteria.h"
#import "WSEditDialogController.h"

@interface ICP_Dialog_Controller : WSEditDialogController {
	IBOutlet WSTextView *icc_description;
	WSTextViewController *icc_description_Controller;
	IBOutlet WSTextField *icc_rating;
	WSListPickerController *icc_rating_Controller;
	BSCriteria *criteria;
}
@property(nonatomic, retain)BSCriteria *criteria;
@property(nonatomic, retain)IBOutlet WSTextView *icc_description;
@property(nonatomic, retain)WSTextViewController *icc_description_Controller;
@property(nonatomic, retain)IBOutlet WSTextField *icc_rating;
@property(nonatomic, retain)WSListPickerController *icc_rating_Controller;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:ID;
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID;
@end
