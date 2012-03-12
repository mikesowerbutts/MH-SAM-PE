//
//  RedFlags_Dialog_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSEditDialogController.h"
#import "BSRedFlag.h"
#import "WSTextView.h"
#import "WSTextViewController.h"

@interface Summary_RedFlags_Dialog_Controller :  WSEditDialogController {
	BSRedFlag *redFlag;
	IBOutlet WSTextView *description;
	WSTextViewController *description_Controller;
}
@property(nonatomic, retain)BSRedFlag *redFlag;
@property(nonatomic, retain)IBOutlet WSTextView *description;
@property(nonatomic, retain)WSTextViewController *description_Controller;
@end
