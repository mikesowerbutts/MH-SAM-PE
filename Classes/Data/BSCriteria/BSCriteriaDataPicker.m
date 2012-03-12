//
//  BSCriteriaDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSCriteriaDataPicker.h"
#import "BSCriteria.h"
#import "BSCriteriaList.h"
#import "BlueSheetDataModel.h"

@implementation BSCriteriaDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSCriteria *cri = (BSCriteria *)[objList objectAtIndex:i];
		[retData addObject:cri.ID];
		[retData addObject:[NSString stringWithFormat:@"%i", i+1]];
		[retData addObject:cri.iccDesc];
		[retData addObject:![cri.value.key isEqualToString:@"0"] ? cri.value.key : @""];
	}
	return [retData autorelease];
}
@end
