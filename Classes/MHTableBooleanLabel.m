//
//  MHTableBooleanLabel.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/10/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTableBooleanLabel.h"
#import "WSBoolean.h"

@implementation MHTableBooleanLabel
@synthesize trueValue, falseValue;
-(id)initWithFrame:(CGRect)frame{	
	return [super initWithFrame:frame];
}
-(void)setValue:(NSString *)theValue{
	WSBoolean *val = [[WSBoolean alloc] initWithString:theValue];
	if(val.value)
		[super setValue:self.trueValue];
	else
		[super setValue:self.falseValue];
	[val release];
	self.hidden = NO;
}

@end
