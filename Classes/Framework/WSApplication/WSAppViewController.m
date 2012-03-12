    //
//  WSAppViewController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSAppViewController.h"
#import "WSPickerField.h"
#import "WSScrollView.h"
#import "WSTableView.h"
#import "WSPopover.h"
#import "WSTextView.h"
#import "WSListPickerField.h"
#import "WSDatePickerField.h"

@implementation WSAppViewController

@synthesize scrollView, keyboardBounds, activeControl;


-(void)setActiveControl:(UIView *)newActiveControl
{
	if(activeControl != nil && activeControl != newActiveControl)
	{
		NSLog(@"Active Control: %@", activeControl);
		[activeControl resignFirstResponder];	
	}
	activeControl = newActiveControl;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[textField resignFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if([[textField class] isSubclassOfClass:[WSPickerField class]])
	{
		return NO;	
	}
	else 
	{
		return YES;
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
	NSLog(@"dealloc WSAppViewController");
    [super dealloc];
}


@end
