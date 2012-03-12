    //
//  WSButtonController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 02/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSButtonController.h"
#import "WSButton.h"
#import "WSStyle.h"
#import "WSUtils.h"

@implementation WSButtonController
@synthesize button, associatedViewController, selected, tag;
-(id)initWithButton:(WSButton *)theButton{
	button = theButton;
	if(!button.inited){
		[button initNormal];
	}
	button.delegate = self;
	[self additionalSetup];
	[button addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
	return self;
}

-(void)additionalSetup{
	
}
-(void)touchUpInside:(NSString *)notification{
	[[NSNotificationCenter defaultCenter] postNotificationName:notification object:self];
	[self toggleSelected];
}
-(void)touchUpInside{
	[self toggleSelected];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"btnTouchUpInside" object:self];
}

-(void)toggleSelected{
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
}


@end
