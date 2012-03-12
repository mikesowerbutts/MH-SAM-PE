//
//  WSToggleButton.m
//  BlueSheet
//
//  Created by Toby Widdowson on 21/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSToggleButtonController.h"
#import "WSToggleButton.h"

@implementation WSToggleButtonController
@synthesize state, stateImages, trueValue;
-(id)initWithButton:(WSToggleButton *)theButton{
	[super initWithButton:theButton];
	self.state = 0;
	self.stateImages = [[NSMutableArray alloc] init];
	[self.stateImages addObject:@""];
	[self.stateImages addObject:@"tick.png"];
	trueValue = [[NSString alloc] initWithString:@"true"];
	return self;
}
-(void)setupState:(int)newState{
	self.state = newState;
	button.imageView.image = [UIImage imageNamed:[stateImages objectAtIndex:self.state]];
}
-(void)setChecked:(NSString *)value{
	if([value isEqualToString:trueValue]){
		[self setupState:1];
	}
}
-(void)touchUpInside{
	if(state < [stateImages count] - 1){
		self.state++;
	}
	else{
		self.state = 0;
	}
	button.imageView.image = [UIImage imageNamed:[stateImages objectAtIndex:state]];
}
-(NSString *)getStringValue{
	if(state == 1){
		return trueValue;
	}
	else{
		return @"";
	}
}
@end
