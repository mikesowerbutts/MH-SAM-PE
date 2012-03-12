//
//  MHTextFieldController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextFieldController.h"
#import "WSDraggableButton.h"
#import "WSDraggableButtonController.h"

@interface MHTextFieldController : WSTextFieldController {
	NSString *flagID;
	WSDraggableButtonController *flagController;
	WSDraggableButton *flagBtn;
}
@property(nonatomic, retain)NSString *flagID;
@property(nonatomic, retain)WSDraggableButtonController *flagController;
@property(nonatomic, retain)WSDraggableButton *flagBtn;
@end
