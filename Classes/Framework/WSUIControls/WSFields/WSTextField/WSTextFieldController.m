    //
//  WSTextFieldController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTextFieldController.h"


@implementation WSTextFieldController
-(id)initWithFieldAndValue:(WSTextField *)theTextBox value:(NSString *)theValue{
	textBox = theTextBox;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	textBox.borderStyle = UITextBorderStyleRoundedRect;
	textBox.text = [theValue stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}


@end
