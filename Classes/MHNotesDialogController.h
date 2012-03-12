//
//  MHNotesDialogController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSEditDialogController.h"
#import "WSTextView.h"
#import "WSTextViewController.h"

@interface MHNotesDialogController : WSEditDialogController {
	IBOutlet WSTextView *tv;
	WSTextViewController *tvC;
}
@property(nonatomic, retain)IBOutlet WSTextView *tv;
@property(nonatomic, retain)WSTextViewController *tvC;
@end
