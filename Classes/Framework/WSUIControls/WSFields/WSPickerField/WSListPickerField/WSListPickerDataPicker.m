//
//  WSListPickerDataPicker.m
//  BlueSheet
//
//  Created by Toby Widdowson on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSListPickerDataPicker.h"
#import "WSKVPairList.h"


@implementation WSListPickerDataPicker
@synthesize kvPairList;
-(id)initWithKVPairList:(WSKVPairList *)theList{
	kvPairList = theList;
	return self;
}
-(NSMutableArray *)getData{
	return [kvPairList getKeysValues];
}
@end
