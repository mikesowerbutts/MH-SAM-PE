//
//  WSContactList.m
//  BlueSheet
//
//  Created by Toby Widdowson on 07/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSContactList.h"
#import "WSContact.h"

@implementation WSContactList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		WSContact *con = [[WSContact alloc] initWithXML:[data GetByIndex:i]];
		[items addObject:con];
	}
}

-(WSContact *)getContactByID:(NSString *)theID{
	if(![theID isEqualToString:@""]){
		for(int i = 0; i < [items count]; i++){
			WSContact *obj = (WSContact *)[items objectAtIndex:i];
			if([obj.ID isEqualToString:theID]){
				return [[obj retain] autorelease];
			}
		}
	}
	return nil;
}

-(WSKVPairList *)GetKVPairList{
	WSKVPairList *kvPairs = [[WSKVPairList alloc] init];
	for(int i = 0; i < [items count]; i++){
		WSContact *con = (WSContact *)[items objectAtIndex:i];
		WSKVPair *kvPair = [[WSKVPair alloc] initWithKeyValue:con.ID aValue:con.contactName];
		[kvPairs.items addObject:kvPair];
	}
	return kvPairs;
}
@end
