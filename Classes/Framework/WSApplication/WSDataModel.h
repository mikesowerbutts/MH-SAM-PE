//
//  WSDataModel.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSXMLObject.h"
#import "WSContact.h"
#import "WSContactList.h"

@interface WSDataModel : NSObject {
	NSString *xmlFileName;
	WSXMLObject *mainXML;
	WSXMLObject *applicationData;
	WSXMLObject *fileData;
	WSContactList *contactsList;
}
@property(nonatomic, retain) NSString *xmlFileName;
@property(nonatomic, retain) WSXMLObject *mainXML;
@property(nonatomic, retain) WSXMLObject *applicationData;
@property(nonatomic, retain) WSXMLObject *fileData;

@property(nonatomic, retain)WSContactList *contactsList;

+(WSDataModel *)instance;
-(id)init:(NSString *)filename;
-(WSXMLObject *)getMainXML;
-(WSXMLObject *)getApplicationData;
-(WSXMLObject *)getFileData;
-(WSContactList *)getContacts;
-(void)updateObjectList:(WSDataObjectList *)objectList updatedObject:(WSDataObject *)theUpdatedObject notificationType:(NSString *)theNotificationType;
-(NSString *)createPrintXML;
-(NSString *)createSaveXML;
-(void)save:(NSString *)xmlToSave;
@end
