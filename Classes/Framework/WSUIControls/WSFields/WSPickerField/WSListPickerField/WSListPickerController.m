    //
//  WSListPickerController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 07/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSListPickerController.h"
#import "WSListPickerField.h"
#import "WSTableViewController.h"
#import "WSKVPairList.h"
#import "WSColumnInfo.h"
#import "WSDataPicker.h"
#import "WSListPickerDataPicker.h"
#import "WSTableViewDataController.h"

@implementation WSListPickerController
@synthesize tableViewController, popoverController, listData, multiSelect, selectedPairs;
-(id)initWithFieldListDataAndValue:(WSListPickerField *)theTextBox listData:(WSKVPairList *)theListData value:(WSKVPair *)theValue multiSelect:(BOOL)ms
{
    selectedPairs = [[WSKVPairList alloc] init];
	if(theValue.key != nil && ![theValue.key isEqualToString:@""] && theValue.value != nil && ![theValue.value isEqualToString:@""]){
		[selectedPairs.items addObject:theValue];
	}
	multiSelect = ms;
	listData = [theListData mutableCopy];
	textBox = theTextBox;
	textBox.text = [theValue.value stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]; 
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	self.delegate = textBox.delegate;
	[textBox setController:self];
	self.view = textBox;
	[textBox addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
	return self;
}

-(void)showList{	
	CGRect sourceRec = CGRectMake(textBox.frame.origin.x, textBox.frame.origin.y, textBox.frame.size.width, textBox.frame.size.height);
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[WSColumnInfo alloc] initID]];
	[colTypes addObject:[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:100 columnHeader:@"" columnTextAlign:UITextAlignmentLeft]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[WSListPickerDataPicker alloc] initWithKVPairList:listData]];
	tableViewController = [[WSTableViewController alloc] initWithCols:dataCon readOnly:YES multiSelect:multiSelect selectedRowsData:selectedPairs tableFrame:CGRectMake(0, 0, 300, 10) columnTypes:colTypes tableTitle:@"" groupMode:@"NONE" showColHeaders:NO];
	tableViewController.mode = @"LIST";
	CGRect dispRec = [tableViewController autosize];
	tableViewController.delegate = self;
	NSMutableArray *subControls = [[NSMutableArray alloc] init];
	[subControls addObject:tableViewController.tableView];
	popoverController = [[WSPopoverViewController alloc] initWithSubControls:self.delegate.view displayRect:dispRec displaySource:sourceRec subControls:subControls];
}

-(void)updateTextBox:(WSKVPairList *)selPairs{
	selectedPairs = [selPairs mutableCopy];
	NSMutableString *val = [[NSMutableString alloc] init];
	for(int i = 0; i < [selectedPairs.items count]; i++)
	{
		WSKVPair *pair = [selectedPairs.items objectAtIndex:i];
		[val appendString:pair.value];
		if(i < [selectedPairs.items count] - 1)
			[val appendString:@", "];
	}
	textBox.text = val;
	[val release];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
	[tableViewController release];
	[popoverController release]; 
	[listData release];
	[selectedPairs release];
}


@end
