    //
//  WSCurrencyFieldController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSCurrencyFieldController.h"


@implementation WSCurrencyFieldController
@synthesize currency;
-(id)initWithFieldAndValue:(WSNumberField *)theTextBox value:(NSString *)theValue
{
	textBox = theTextBox;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	currency = [[WSCurrency alloc] initWithString:theValue];
	textBox.keyboardType = UIKeyboardTypeNumberPad;
	textBox.text = [currency getFormattedValue];
	[textBox addTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
	return self;
}
-(void)formatValue:(id)sender
{
	NSString *rawText = ((UITextField *)sender).text;
	if([rawText rangeOfString:@"."].location == NSNotFound || [rawText rangeOfString:@"."].location != ([rawText length] - 1)){
		[textBox removeTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
		currency = [[WSCurrency alloc] initWithString:rawText];
		textBox.text = [currency getFormattedValue];
		[textBox addTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
	}
}
@end
