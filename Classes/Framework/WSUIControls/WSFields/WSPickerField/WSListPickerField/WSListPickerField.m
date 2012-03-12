//
//  WSListPickerField.m
//  BlueSheet
//
//  Created by Toby Widdowson on 07/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSListPickerField.h"
#import "WSListPickerController.h"


@implementation WSListPickerField

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	[self.controller showList];
}

@end
