//
//  BSDragObjectList.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSDragObjectList.h"
#import "BSDragObject.h"

@implementation BSDragObjectList
-(void)buildList{
	for(int i = 0; i < [[data children] count]; i++){
		BSDragObject *drg = [[BSDragObject alloc] initWithXML:[data GetByIndex:i] ID:ID];
		[items addObject:[drg autorelease]];//Leak
	}
}
@end
