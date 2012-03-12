//
//  WSInfluenceList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSInfluenceList.h"
#import "BSInfluence.h"

@implementation BSInfluenceList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSInfluence *inf = [[BSInfluence alloc] initWithXML:[data GetByIndex:i] ID:ID];
		[items addObject:[inf autorelease]];//Leak
	}
}
@end
