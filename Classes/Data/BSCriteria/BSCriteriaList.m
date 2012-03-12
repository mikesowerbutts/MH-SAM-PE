//
//  BSCriteriaList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSCriteriaList.h"
#import "BSCriteria.h"

@implementation BSCriteriaList
@synthesize sourceList;
-(id)init:(WSXMLObject *)theData sourceList:(WSKVPairList *)theSourceList ID:(NSString *)theID
{
	[super init:theData ID:theID];
    self.sourceList = theSourceList;
	data = theData;
	self.items = [[[NSMutableArray alloc] init] autorelease];
	[self buildList];
	return self;
}
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSCriteria *cri = [[BSCriteria alloc] initWithXML:[data GetByIndex:i] SourceList:[[sourceList copy] autorelease] ID:[NSString stringWithFormat:@"ICC.%@", ID]];
		[items addObject:[cri autorelease]];
	}
}
-(void)dealloc{
    [super dealloc];
    [sourceList release];
}
@end
