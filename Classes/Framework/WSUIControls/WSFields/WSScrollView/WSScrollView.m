//
//  WSScrollView.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSScrollView.h"


@implementation WSScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touched base scrollview");
	//if([event.type == UIControlEventTouchUpInside){
		//[[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewSingleTap" object:self];
	//}
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
	//[self scrollViewToCenterOfScreen:textField];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
	//[self scrollViewToCenterOfScreen:textView];
}

@end
