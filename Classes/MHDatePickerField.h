//
//  MHDatePickerField.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTextField.h"
#import "WSDraggableButton.h"
#import "MHFlagButtonController.h"

@interface MHDatePickerField : WSDatePickerField {
	NSString *flagID;
	MHFlagButtonController *flagController;
	WSDraggableButton *flagBtn;	
}
@property(nonatomic, retain)NSString *flagID;
@property(nonatomic, retain)MHFlagButtonController *flagController;
@property(nonatomic, retain)WSDraggableButton *flagBtn;

-(void)checkFlag:(NSString *)theFlagID;
@end