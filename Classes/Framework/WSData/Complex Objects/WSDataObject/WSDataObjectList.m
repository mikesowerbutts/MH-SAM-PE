//
//  ObjectList.m
//  BlueSheet
//
//  Created by Toby Widdowson on 14/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDataObjectList.h"
#import "WSDataObject.h"
#import "WSXMLObject.h"

@implementation WSDataObjectList
@synthesize items, xmlNodeName;
-(id)init:(WSXMLObject *)theData{
	[super init];
	data = theData;
	items = [[NSMutableArray alloc] init];
	[self buildList];
	return self;
}
-(void)buildList{
}
-(WSDataObject *)getObjectByID:(NSString *)theID{
	if(![theID isEqualToString:@""]){
		for(int i = 0; i < [self.items count]; i++){
			WSDataObject *obj = (WSDataObject *)[items objectAtIndex:i];
			if([obj.ID isEqualToString:theID]){
				return obj;
			}
		}
	}
	return nil;
}
-(void)removeObjectByID:(NSString *)theID{
	NSMutableArray *newItems = [[NSMutableArray alloc] init];
	for(int i = 0; i < [items count]; i++){
		WSDataObject *obj = [items objectAtIndex:i];
		if(![obj.ID isEqualToString:theID]){
			[newItems addObject:obj];
		}
	}
	items = [newItems mutableCopy];
	[newItems release];
}
-(NSString *)serializeObjects{
	NSMutableString *serializedObjectsStr = [[NSMutableString alloc] init];
	[serializedObjectsStr appendFormat:@"<%@>", xmlNodeName];
	for(int i = 0; i < [items count]; i++){
		WSDataObject *obj = (WSDataObject *)[items objectAtIndex:i];
		[serializedObjectsStr appendString:[obj serialize]];
	}
	[serializedObjectsStr appendFormat:@"</%@>", xmlNodeName];
	return serializedObjectsStr;
}
-(void)dealloc{
	[super dealloc];
	[items release];
}
@end
