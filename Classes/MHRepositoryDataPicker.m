//
//  MHRepositoryDataPicker.m
//  MH SAM PE
//
//  Created by Toby Widdowson on 17/11/2011.
//  Copyright (c) 2011 White Springs Ltd. All rights reserved.
//

#import "MHRepositoryDataPicker.h"

@implementation MHRepositoryDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [theXML.children count]; i++){
        WSXMLObject *tN = [theXML GetByIndex:i];
		[retData addObject:[tN GetAttribute:@"ID"]];
        [retData addObject:[tN GetAttribute:@"Description"]];
	}
	return [retData autorelease];
}
@end
