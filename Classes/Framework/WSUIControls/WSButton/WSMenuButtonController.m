//
//  WSMenuButtonController.m
//  CRMSync
//
//  Created by Toby Widdowson on 23/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSMenuButtonController.h"


@implementation WSMenuButtonController
@synthesize editDialog_Controller;
-(id)initWithButton:(WSButton *)theButton{
	[super initWithButton:theButton];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTouchedUpInside:) name:@"btnTouchUpInside" object:nil];
	return self;
}
-(void)btnTouchedUpInside:(NSNotification *)notification{
	WSButtonController *sbtn = (WSButtonController *)[notification object];
	if(sbtn == self){
		[editDialog_Controller setupDialog:nil];
		[editDialog_Controller showPopoverFromRect:button.frame];
	}
}
@end
