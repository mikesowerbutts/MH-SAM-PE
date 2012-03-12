//
//  BSBestInfoDataPicker.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSBestInfoDataPicker.h"
#import "WSDataObjectList.h"
#import "BSBestInfo.h"
#import "WSContact.h"

@implementation BSBestInfoDataPicker
-(NSMutableArray *)getData{
	NSMutableArray *retData = [[NSMutableArray alloc] init];
	for(int i = 0; i < [objList count]; i++){
		BSBestInfo *bi = (BSBestInfo *)[objList objectAtIndex:i];
		[retData addObject:bi.ID];
		[retData addObject:bi.what];
		WSContact *con = [bi getWhoContact];
		[retData addObject:con.contactName];
		[retData addObject:[bi.when getFormattedDate]];
	}
	return [retData autorelease];
}
@end
