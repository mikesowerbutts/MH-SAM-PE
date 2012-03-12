//
//  WSDateField.h
//  BlueSheet
//
//  Created by Toby Widdowson on 04/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WSPopoverViewController.h"
#import "WSDatePickerField.h"
#import "WSFieldController.h"
#import "WSDate.h"

@interface WSDateFieldController : WSFieldController<UITextFieldDelegate> {
	UIDatePicker *datePicker;
	WSDate *date;
	WSPopoverViewController *popoverController;
}
@property(nonatomic, retain)UIDatePicker *datePicker;
@property(nonatomic, retain)WSDate *date;
@property(nonatomic, retain)WSPopoverViewController *popoverController;

-(id)initWithFieldAndDate:(WSDatePickerField *)theTextBox currentDate:(NSString *)theCurrentDate;
-(id)initWithFieldAndWSDate:(WSDatePickerField *)theTextBox currentDate:(WSDate *)theCurrentDate;
-(void) changeDateInTextBox:(id)sender;
-(void)showPicker;
@end
