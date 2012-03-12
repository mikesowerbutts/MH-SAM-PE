//
//  WSBooleanLabel.m
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSBooleanLabel.h"
#import "WSBoolean.h"

@implementation WSBooleanLabel
@synthesize trueValue, falseValue;
-(id)initWithFrame:(CGRect)frame{	
	return [super initWithFrame:frame];
}
-(void)setValue:(NSString *)theValue{
	WSBoolean *val = [[WSBoolean alloc] initWithString:theValue];
	if(val.value){
		[super setValue:self.trueValue];
	}
	else{
		[super setValue:self.falseValue];
	}
	[val release];
	self.hidden = NO;
}
@end
