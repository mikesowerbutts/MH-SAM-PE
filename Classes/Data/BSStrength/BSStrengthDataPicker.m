//
//  BSStrengthDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSStrengthDataPicker.h"
#import "BSStrengthList.h"
#import "BlueSheetDataModel.h"
#import "BSStrength.h"

@implementation BSStrengthDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSStrength *str = (BSStrength *)[objList objectAtIndex:i];
		[retData addObject:str.ID];
		[retData addObject:str.description];
	}
	return [retData autorelease];
}
@end
