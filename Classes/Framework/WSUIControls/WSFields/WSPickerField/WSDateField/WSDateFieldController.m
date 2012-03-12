//
//  WSDateField.m
//  BlueSheet
//
//  Created by Toby Widdowson on 04/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WSDateFieldController.h"
#import "WSDatePickerField.h";
#import "WSPopoverViewController.h"

@implementation WSDateFieldController

@synthesize datePicker, date, popoverController;

-(id)initWithFieldAndDate:(WSDatePickerField *)theTextBox currentDate:(NSString *)theCurrentDate
{
	date = [[WSDate alloc] initWithString:theCurrentDate];
	textBox = theTextBox;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	self.delegate = textBox.delegate;
	[textBox setController:self];
	self.view = textBox;
	[textBox addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
	textBox.text = [date getFormattedDate];
	return self;
}
-(id)initWithFieldAndWSDate:(WSDatePickerField *)theTextBox currentDate:(WSDate *)theCurrentDate
{
	date = theCurrentDate;
	textBox = theTextBox;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	self.delegate = textBox.delegate;
	[textBox setController:self];
	self.view = textBox;
	[textBox addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchUpInside];
	textBox.text = [date getFormattedDate];
	return self;
}
-(void)showPicker
{	
	CGRect sourceRec = CGRectMake(textBox.frame.origin.x, textBox.frame.origin.y, textBox.frame.size.width, textBox.frame.size.height);
	CGRect dispRec = CGRectMake(0, 0, 300, 200);
	datePicker = [[UIDatePicker alloc] initWithFrame:dispRec];
	datePicker.datePickerMode = UIDatePickerModeDate;
	datePicker.date = [NSDate date];
	[datePicker addTarget:self action:@selector(changeDateInTextBox:) forControlEvents:UIControlEventValueChanged];
	NSMutableArray *subControls = [[NSMutableArray alloc] init];
	[subControls addObject:datePicker];
	popoverController = [[WSPopoverViewController alloc] initWithSubControls:self.delegate.view displayRect:dispRec displaySource:sourceRec subControls:subControls];
	[subControls release];
}

-(void) changeDateInTextBox:(id)sender
{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy.MM.dd"];
	NSString *dt = [df stringFromDate:datePicker.date];
	[df release];
	date = [[WSDate alloc] initWithString:dt];
	textBox.text = [date getFormattedDate];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	return NO;
}

-(void)dealloc
{
	[super dealloc];
	[datePicker release];
	[date release];
	[popoverController release];
	[textBox release];
}

@end
