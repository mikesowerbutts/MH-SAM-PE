//
//  WSKVPairList.m
//  BlueSheet
//
//  Created by Toby Widdowson on 13/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSKVPairList.h"
#import "WSKVPair.h"

@implementation WSKVPairList
@synthesize items;
-(id)initWithXMLNode:(WSXMLObject *)theXMLObj{
	[self setupVars];
	for(int i = 0; i < [[theXMLObj children] count]; i++){
		WSXMLObject *obj = (WSXMLObject *)[theXMLObj GetByIndex:i];
		WSKVPair *kvp = [[WSKVPair alloc] initWithKeyValue:[obj GetAttribute:@"ID"] aValue:[obj GetAttribute:@"Label"]];
		[items addObject:kvp];
	}
	return self;
}
-(id)init{
	[self setupVars];
	return self;
}
-(void)setupVars{
	items = [[NSMutableArray alloc] init];
}

-(WSKVPair *)getPairByKey:(NSString *)key{
	NSString *tKey = [[NSString alloc] initWithString:[key stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	tKey = [tKey stringByReplacingOccurrencesOfString:@"+" withString:@""];
	WSKVPair *kvp = nil;
	for(int i = 0; i < [items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		if([kvpTemp.key isEqualToString:tKey]){
			kvp = kvpTemp;
			break;
		}
	}
	return kvp;
}
-(WSKVPairList *)getPairListByValue:(NSString *)value{
	WSKVPairList *kvpList = [[WSKVPairList alloc] init];
	for(int i = 0; i < [items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		if([kvpTemp.value isEqualToString:value]){
			[kvpList.items addObject:kvpTemp];
		}
	}
	return kvpList;
}
-(NSMutableArray *)getValues{
	NSMutableArray *vals = [[NSMutableArray alloc] initWithCapacity:[items count]];
	for(int i = 0; i < [items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		[vals addObject:kvpTemp.value];
	}
	return vals;
}
-(NSMutableArray *)getKeys{
	NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:[items count]];
	for(int i = 0; i < [items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		[keys addObject:kvpTemp.key];
	}
	return keys;
}
-(NSMutableArray *)getKeysValues{
	
	NSMutableArray *both = [[NSMutableArray alloc] initWithCapacity:[items count]];
	for(int i = 0; i < [items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		[both addObject:kvpTemp.key];
		[both addObject:kvpTemp.value];
	}
	return both;
}
-(WSKVPairList *)mutableCopy{
	WSKVPairList *copy = [[WSKVPairList alloc] init];
	for(int i = 0; i < [self.items count]; i++){
		WSKVPair *kvpTemp = (WSKVPair *)[items objectAtIndex:i];
		[copy.items addObject:kvpTemp];
	}
	return copy;
}
-(void)removePairByKey:(NSString *)key{
	for(int i = 0; i < [items count]; i++){
		WSKVPair *pair = [items objectAtIndex:i];
		if([pair.key isEqualToString:key]){
			[items removeObjectAtIndex:i];
			break;
		}
	}
}

@end
