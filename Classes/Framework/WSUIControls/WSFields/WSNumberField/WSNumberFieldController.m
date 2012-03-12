    //
//  WSNumberFieldController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSNumberFieldController.h"
#import "WSNumberField.h"

@implementation WSNumberFieldController
@synthesize numFmtr;
-(void)initWithFieldAndValue:(WSNumberField *)theTextBox value:(NSString *)theValue
{
	textBox = theTextBox;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	numFmtr = [[NSNumberFormatter alloc] init];
	[numFmtr setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numFmtr setNumberStyle:NSNumberFormatterDecimalStyle];
	textBox = theTextBox;
	self.delegate = textBox.delegate;
	textBox.keyboardType = UIKeyboardTypeNumberPad;
	[textBox addTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
}
-(void)formatValue:(id)sender
{
	NSString *rawText = ((UITextField *)sender).text;
	if([rawText rangeOfString:@"."].location == NSNotFound || [rawText rangeOfString:@"."].location != ([rawText length] - 1)){
		[textBox removeTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
		NSNumber *num = [numFmtr numberFromString:rawText];
		NSMutableString *formattedValue = [[[NSMutableString alloc] initWithString:[numFmtr stringFromNumber:num]] retain];
		textBox.text = formattedValue;
		[textBox addTarget:self action:@selector(formatValue:) forControlEvents:UIControlEventEditingChanged];
	}
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[textBox release];
	[numFmtr release];
}


@end
