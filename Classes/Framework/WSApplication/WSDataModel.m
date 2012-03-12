//
//  WSDataModel.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDataModel.h"
#import "WSXMLObject.h"
#import "WSUtils.h"

static WSDataModel *baseInstance = nil;
@implementation WSDataModel
@synthesize xmlFileName, mainXML, applicationData, fileData, contactsList;

+(WSDataModel *)instance{
	@synchronized(self){
		if(baseInstance == nil){
			baseInstance = [[WSDataModel alloc] init];
		}
	}
	return baseInstance;
}
-(id)init:(NSString *)filename{
	//[WSUtils WriteStringToFile:filename stringToSave:[WSUtils StringFromResourcesFile:filename]];
	xmlFileName = [[NSString alloc] initWithString:filename];
	NSString *fileStr = [WSUtils MakeXMLStringSafe:[WSUtils StringFromDocumentsFile:xmlFileName]];
	if(fileStr.length > 0){
		mainXML = [[WSXMLObject alloc] init:fileStr];
		if(mainXML != nil){
			applicationData = [mainXML Get:@"ApplicationData"];
			fileData = [mainXML Get:@"FileData"];
		}
	}
	contactsList = [[WSContactList alloc] init:[self.applicationData Get:@"Contacts"]];
	baseInstance = self;
	return self;
}
-(WSXMLObject *)getMainXML{
	return mainXML;
}
-(WSXMLObject *)getApplicationData{
	return applicationData;
}
-(WSXMLObject *)getFileData{
	return fileData;
}
-(WSContactList *)getContacts{
	return contactsList;
}
-(NSString *)getXMLFileName{
	return xmlFileName;
}
-(void)updateObjectList:(WSDataObjectList *)objectList updatedObject:(WSDataObject *)theUpdatedObject notificationType:(NSString *)theNotificationType{
	BOOL triggerChanged = NO;
	for(int i = 0; i < [objectList.items count]; i++){
		WSDataObject *obj = [objectList.items objectAtIndex:i];
		if([obj.ID isEqualToString:theUpdatedObject.ID]){
			[objectList.items replaceObjectAtIndex:i withObject:theUpdatedObject];
			triggerChanged = YES;
			break;
		}
		else if(i == [objectList.items count] - 1){
			NSLog(@"inserting new item!");
			[objectList.items addObject:theUpdatedObject];
			triggerChanged = YES;
			break;
		}
	}
	if(triggerChanged){
		NSMutableString *notificationStr = [[NSMutableString alloc] initWithString:theNotificationType];
		[notificationStr appendString:@"Changed"];
		[[NSNotificationCenter defaultCenter] postNotificationName:notificationStr object:theUpdatedObject];
		
	}
}
-(NSString *)createSaveXML{
	return @"";
}
-(NSString *)createPrintXML{
	return @"";
}
-(void)save:(NSString *)xmlToSave{
	[WSUtils WriteStringToFile:baseInstance.xmlFileName stringToSave:xmlToSave];
}
-(void)dealloc
{
	[super dealloc];
	[xmlFileName release];
	[mainXML release];
	[applicationData release];
	[fileData release];
}

@end
