//
//  WSDatePickerField.m
//  BlueSheet
//
//  Created by Toby Widdowson on 05/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDatePickerField.h"
#import "WSDateFieldController.h"


@implementation WSDatePickerField

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	[self.controller showPicker];
}

-(void)dealloc
{
	[super dealloc];
}
@end
