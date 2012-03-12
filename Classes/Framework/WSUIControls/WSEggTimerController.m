//
//  WSEddTimerController.m
//  CRMSync
//
//  Created by Toby Widdowson on 30/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSEggTimerController.h"


@implementation WSEggTimerController
@synthesize message, activityIndicator;
-(id)initWithMessage:(NSString *)messageText{
	NSArray *nibObjs = [[NSBundle mainBundle] loadNibNamed:@"EggTimer" owner:self options:nil];
	UIView *nibView = [nibObjs objectAtIndex:0];
	self.view = nibView;
	self.view.backgroundColor = [UIColor clearColor];
	message.text = messageText;
	activityIndicator.hidesWhenStopped = YES;
	[activityIndicator startAnimating];
	return self;
}
@end
