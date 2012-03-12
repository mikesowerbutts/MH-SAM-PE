//
//  WSActionDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSActionPossibleActionsDataPicker.h"
#import "WSAction.h"

@implementation BSActionPossibleActionsDataPicker
-(id)initWithList:(NSMutableArray *)theList ID:(NSString *)theID{
	[super initWithList:theList ID:theID];
	return self;
}
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		WSAction *act = (WSAction *)[objList objectAtIndex:i];
		[retData addObject:act.ID];
		[retData addObject:act.what];
		WSContact *con = [act getWhoContact];
		[retData addObject:con.contactName];
		[retData addObject:[act.when getFormattedDate]];
		[retData addObject:[act.check numberValue]];
	}
	return [retData autorelease];
}
@end
