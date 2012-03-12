//
//  WSActionDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSActionBestActionsDataPicker.h"
#import "WSAction.h"

@implementation BSActionBestActionsDataPicker
-(id)initWithList:(NSMutableArray *)theList{
	[super initWithList:theList ID:ID];
	return self;
}
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		WSAction *act = (WSAction *)[objList objectAtIndex:i];
		if(act.check.value){
			[retData addObject:act.ID];
			[retData addObject:act.what];
			WSContact *con = [act getWhoContact];
			[retData addObject:con.contactName];
			[retData addObject:[act.when getFormattedDate]];
		}
	}
	return [retData autorelease];
}
@end
