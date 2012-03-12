//
//  WSPickerField.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTextField.h"

@interface WSPickerField : WSTextField<UITextFieldDelegate> {
	UIViewController *controller;
}
@property(nonatomic, retain) UIViewController *controller;
@end
