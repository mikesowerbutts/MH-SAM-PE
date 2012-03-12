//
//  WSBoolean.m
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSBoolean.h"


@implementation WSBoolean
@synthesize rawValue, value;
-(id)initWithString:(NSString *)theRawValue{
	rawValue = theRawValue;
	value = NO;
	if([rawValue isEqualToString:@"1"]){
		value = YES;
	}
	else if([[rawValue uppercaseString] isEqualToString:@"TRUE"]){
		value = YES;
	}
	return self;
}
-(NSString *)numberValue{
	if(value == YES){
		return @"1";
	}
	else{
		return @"0";
	}
}
-(NSString *)stringValue{
	if(value == YES){
		return @"true";
	}
	else{
		return @"false";
	}
}
@end
