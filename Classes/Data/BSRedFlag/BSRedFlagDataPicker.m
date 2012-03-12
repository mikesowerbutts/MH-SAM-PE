//
//  BSRedFlagDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSRedFlagDataPicker.h"
#import "BSRedFlag.h"
#import "BSRedFlagList.h"
#import "BlueSheetDataModel.h"

@implementation BSRedFlagDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSRedFlag *rf = (BSRedFlag *)[objList objectAtIndex:i];
		[retData addObject:rf.ID];
		[retData addObject:rf.description];
	}
	return [retData autorelease];//Leak
}
@end
