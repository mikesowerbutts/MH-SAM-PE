//
//  BSBestInfoList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSBestInfoList.h"
#import "BSBestInfo.h"

@implementation BSBestInfoList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSBestInfo *bi = [[BSBestInfo alloc] initWithXML:[data GetByIndex:i] ID:ID];
		[items addObject:[bi autorelease]];
	}
}
@end
