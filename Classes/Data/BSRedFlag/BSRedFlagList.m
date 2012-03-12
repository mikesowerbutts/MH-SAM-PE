//
//  BSRedFlagList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSRedFlagList.h"


@implementation BSRedFlagList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSRedFlag *rf = [[BSRedFlag alloc] initWithXML:[data GetByIndex:i] ID:ID];
		[items addObject:[rf autorelease]];
	}
}
@end
