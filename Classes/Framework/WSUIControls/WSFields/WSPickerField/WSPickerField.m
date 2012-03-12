//
//  WSPickerField.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSPickerField.h"


@implementation WSPickerField
@synthesize controller;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.delegate setActiveControl:self];
}
@end
