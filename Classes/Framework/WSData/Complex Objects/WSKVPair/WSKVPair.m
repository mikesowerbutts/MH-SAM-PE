//
//  WSKVPair.m
//  BlueSheet
//
//  Created by Toby Widdowson on 13/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSKVPair.h"

@implementation WSKVPair
@synthesize key, value, dataValue, objectValue;
-(id)initWithKeyValue:(NSString *)theKey aValue:(NSString *)theValue{
	self.key = [NSString stringWithString:[theKey stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	self.value = [NSString stringWithString:[theValue stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	return self;
}
-(id)initWithKeyDataValue:(NSString *)theKey aValue:(NSMutableData *)theValue{
	self.key = [NSString stringWithString:[theKey stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	self.dataValue = theValue;
	return self;
}
-(id)initWithKeyObjectValue:(NSString *)theKey aObject:(NSObject *)theValue{
	self.key = [NSString stringWithString:[theKey stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	self.objectValue = theValue;
	return self;
}
-(id)copyObject{
	WSKVPair *kvPair = [[WSKVPair alloc] initWithKeyValue:key aValue:value];
	return kvPair;
}
@end
