//
//  WSActionList.m
//  BlueSheet
//
//  Created by Toby Widdowson on 07/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSActionList.h"
#import "WSAction.h"

@implementation WSActionList
-(void)buildList{
	//NSLog(@"data.outerXML: %@", data.outerXML);
	//NSLog(@"***");
	for(int i = 0; i < [[data children] count]; i++){
		WSXMLObject *obj = [data GetByIndex:i];
		if(obj == nil){NSLog(@"obj is nil: %@", obj);}
		WSAction *act = [[WSAction alloc] initWithXML:obj];
		[items addObject:act];
	}
}
@end
