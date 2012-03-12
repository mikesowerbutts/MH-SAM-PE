//
//  DataController.m
//  TableView
//
//  Created by Toby Widdowson on 27/04/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTableViewDataController.h"
#import "WSDataPicker.h"

@implementation WSTableViewDataController
@synthesize list, dataPicker;

-(id)initWithPicker:(WSDataPicker *)theDataPicker
{
	if(self = [super init]){
		dataPicker = theDataPicker;
		list = [dataPicker getData];
	}
	return self;
}

-(unsigned)countOfList{
	return [[self getList] count];
}

-(id)objectInListAtIndex:(unsigned)theIndex{
	return [list objectAtIndex:theIndex];
}
-(NSMutableArray *)getList{
	list = [dataPicker getData];
	return list;
}

-(void)dealloc{
	[list release];
	[dataPicker release];
	[super dealloc];
}
@end
