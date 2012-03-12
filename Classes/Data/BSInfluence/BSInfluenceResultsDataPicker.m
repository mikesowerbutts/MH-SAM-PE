//
//  BSInfluenceDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSInfluenceResultsDataPicker.h"
#import "BSInfluence.h"

@implementation BSInfluenceResultsDataPicker
-(id)initWithList:(NSMutableArray *)theList ID:(NSString *)theID{
	[super initWithList:theList ID:theID];
	return self;
}
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSInfluence *inf = (BSInfluence *)[objList objectAtIndex:i];
		[retData addObject:[NSString stringWithFormat:@"%@|%@", inf.ID, inf.flagID]];
		[retData addObject:inf.resultDescription];
	}
	return [retData autorelease];
}
@end
