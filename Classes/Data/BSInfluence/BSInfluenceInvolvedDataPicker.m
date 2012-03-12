//
//  BSInfluenceDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSInfluenceInvolvedDataPicker.h"
#import "BSInfluence.h"
#import "BlueSheetDataModel.h"
@implementation BSInfluenceInvolvedDataPicker
-(NSMutableArray *)getData{
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	objList = [[bluesheetDataModel getInfluences] items];
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSInfluence *inf = (BSInfluence *)[objList objectAtIndex:i];
		[retData addObject:[NSString stringWithFormat:@"%@|%@", inf.ID, inf.flagID]];
		WSContact *con = [[bluesheetDataModel getContacts] getObjectByID:inf.contactID];
		[retData addObject:con != nil ? [con getNameTitle] : @""];
		[retData addObject:inf.roles != nil ? [inf.roles getKeysAsCSV] :@""];
		[retData addObject:inf.degree != nil ? inf.degree.key :@""];
		[retData addObject:inf.mode != nil ? inf.mode.key :@""];
	}
	return [retData autorelease];
}
@end
