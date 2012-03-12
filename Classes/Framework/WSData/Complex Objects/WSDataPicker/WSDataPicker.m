//
//  WSDataPicker.m
//  BlueSheet
//
//  Created by Toby Widdowson on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDataPicker.h"


@implementation WSDataPicker
@synthesize objList;
-(id)initWithList:(NSMutableArray *)theList{
	objList = theList;
	return self;
}
-(NSMutableArray *)getData{
	return nil;
}
-(void)removeObjectByID:(NSString *)idToRemove{
	for(int i = 0; i < [objList count]; i++){
		if([[[objList objectAtIndex:i] ID] isEqualToString:idToRemove]){
			[objList removeObjectAtIndex:i];
		}
	}
}
@end
