//
//  BuyingInfluences_Results_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 10/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextView.h"
#import "WSEditDialogController.h"
#import "WSTextViewController.h"
#import "BSInfluence.h"

@interface BuyingInfluences_Results_Dialog_Controller : WSEditDialogController {
	IBOutlet WSTextView *description;
	WSTextViewController *description_Controller;
	BSInfluence *influence;
}
@property(nonatomic, retain)BSInfluence *influence;
@property(nonatomic, retain)IBOutlet WSTextView *description;
@property(nonatomic, retain)WSTextViewController *description_Controller;
@end
