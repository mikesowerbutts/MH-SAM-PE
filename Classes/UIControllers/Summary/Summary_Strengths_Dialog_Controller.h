//
//  Strengths_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSEditDialogController.h"
#import "BSStrength.h"
#import "WSTextView.h"
#import "WSTextViewController.h"

@interface Summary_Strengths_Dialog_Controller :  WSEditDialogController {
	BSStrength *strength;
	IBOutlet WSTextView *description;
	WSTextViewController *description_Controller;
}
@property(nonatomic, retain)BSStrength *strength;
@property(nonatomic, retain)IBOutlet WSTextView *description;
@property(nonatomic, retain)WSTextViewController *description_Controller;
@end
