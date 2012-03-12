//
//  WSTextFieldController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextField.h"
#import "WSFieldController.h"

@interface WSTextFieldController : WSFieldController {
}
-(id)initWithFieldAndValue:(WSTextField *)theTextBox value:(NSString *)theValue;
@end
