//
//  BSInfluenceDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSInfluenceCoveredDataPicker.h"
#import "BSInfluence.h"

@implementation BSInfluenceCoveredDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSInfluence *inf = (BSInfluence *)[objList objectAtIndex:i];
		[retData addObject:[NSString stringWithFormat:@"%@|%@", inf.ID, inf.flagID]];
		[retData addObject:inf.cover.value];
		[retData addObject:inf.coverDescription];
	}
	return [retData autorelease];
}
@end
