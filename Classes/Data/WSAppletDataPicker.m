//
//  WSAppletDataPicker.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "WSAppletDataPicker.h"

@implementation WSAppletDataPicker
-(void)removeObjectByID:(NSString *)idToRemove{
	for(int i = 0; i < [objList count]; i++){
		WSDataObject *obj = [objList objectAtIndex:i];
		if([obj.ID isEqualToString:idToRemove]){
			[objList removeObjectAtIndex:i];
		}
	}
}

@end
