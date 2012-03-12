//
//  BSStrengthList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSStrengthList.h"
#import "BSStrength.h"

@implementation BSStrengthList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSStrength *str = [[BSStrength alloc] initWithXML:[data GetByIndex:i] ID:ID];
		[items addObject:[str autorelease]];
	}
}
@end
