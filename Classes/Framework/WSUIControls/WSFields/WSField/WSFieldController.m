    //
//  WSFieldController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSFieldController.h"


@implementation WSFieldController
@synthesize delegate, saveNodeTemplate;

-(NSString *)createSave{
	return @"";
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
	[delegate release];
}


@end
