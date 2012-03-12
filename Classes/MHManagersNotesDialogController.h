//
//  MHManagersNotesDialogController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 16/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSScrollableEditDialogController.h"
#import "WSDateFieldController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"
#import "WSTextField.h"

@interface MHManagersNotesDialogController : WSScrollableEditDialogController {
	NSMutableArray *tvControllers;
	WSDateFieldController *dateController;
	IBOutlet WSTextField *date;
}
@property(nonatomic, retain)IBOutlet WSTextField *date;
@property(nonatomic, retain)NSMutableArray *tvControllers;
@property(nonatomic, retain)WSDateFieldController *dateController;
@end
