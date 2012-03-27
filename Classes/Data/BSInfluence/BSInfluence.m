//
//  BSInfluence.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSInfluence.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"

@implementation BSInfluence
@synthesize nameTitle, roles, degree, mode, resultDescription, cover, coverDescription, contactID;
-(id)initWithXML:(WSXMLObject *)theXMLObj ID:(NSString *)theID
{
	[super initWithXML:theXMLObj ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:dataID];
	[self initVarsSub];
	if(xmlObj != nil){
		WSXMLObject *obj = [xmlObj Get:@"NameTitleLoc/NameTitle"];
		NSString *contactIDAtt = [obj GetAttribute:@"contactID"];
		NSString *str = nil;
		self.contactID = contactIDAtt;
		self.nameTitle = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"NameTitleLoc/Role"];
		str = [WSUtils StringFromNode:obj];
		NSArray *roleParts = [[WSUtils URLDecode:str] componentsSeparatedByString:@","];
		if(str != nil && ![str isEqualToString:@""]){
			WSKVPairList *rolesList = [[WSKVPairList alloc] init];
			for(int i = 0; i < [roleParts count]; i++)
				[rolesList.items addObject:[[bluesheetDataModel getInfluenceRole] getPairByKey:[roleParts objectAtIndex:i]]];
			self.roles = rolesList;
			[rolesList release];
		}
		obj = [xmlObj Get:@"NameTitleLoc/Degree"];
		str = [WSUtils StringFromNode:obj];
		if(str != nil && ![str isEqualToString:@""]){
			self.degree = [[bluesheetDataModel getInfluenceDegree] getPairByKey:str];
		}
		obj = [xmlObj Get:@"NameTitleLoc/Mode"];
		str = [WSUtils StringFromNode:obj];
		if(str != nil && ![str isEqualToString:@""])
			self.mode = [[bluesheetDataModel getInfluenceMode] getPairByKey:str];
		obj = [xmlObj Get:@"Result/Description"];
		self.resultDescription = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"Cover/Rating"];
		self.cover = [[bluesheetDataModel howWellIsBaseCovered] getPairByKey:[WSUtils StringFromNode:obj]];
		if(cover == nil)
			self.cover = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
		obj = [xmlObj Get:@"Cover/Description"];
		self.coverDescription = [WSUtils StringFromNode:obj];
	}
	return self;
}
-(void)setTheContactID:(NSString *)newContactID{
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:dataID];
	self.contactID = newContactID;
	WSContact *con = (WSContact *)[[bluesheetDataModel getContacts] getObjectByID:self.contactID];
	self.nameTitle = [con getNameTitle];
}
-(void)initVarsSub{
	self.contactID = [[[NSString alloc] initWithString:@""] autorelease];
	self.nameTitle = [[[NSString alloc] initWithString:@""] autorelease];
	self.roles = [[[WSKVPairList alloc] init] autorelease];
	self.degree = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
	self.mode = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
	self.resultDescription = [[[NSString alloc] initWithString:@""] autorelease];
	self.cover = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
	self.coverDescription = [[[NSString alloc] initWithString:@""] autorelease];
}
-(id)copyObject{
	BSInfluence *inf = [[BSInfluence alloc] initWithXML:nil ID:dataID];
	inf.ID = self.ID;
	inf.dataID = self.dataID;
	inf.flagID = self.flagID;
	inf.contactID = self.contactID;
	inf.nameTitle = self.nameTitle;
	inf.roles = [[self.roles copy] autorelease];
	inf.degree = [[self.degree copy] autorelease];
	inf.mode = [[self.mode copy] autorelease];
	inf.resultDescription = self.resultDescription;
	inf.cover = [[self.cover copy] autorelease];
	inf.coverDescription = self.coverDescription;
	return inf;
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] initWithString:@""];
	[retString appendFormat:@"<Influence>"];
        [retString appendString:[super serialize]];
        [retString appendFormat:@"<NameTitleLoc>"];
        [retString appendFormat:@"<NameTitle locationID='' contactID='%@'>%@</NameTitle>", contactID != nil ? contactID : @"", [WSUtils URLEncode:nameTitle]];
            [retString appendFormat:@"<Role locationID=''>%@</Role>", [WSUtils URLEncode:[roles getKeysAsCSV]]];
            [retString appendFormat:@"<Degree locationID=''>%@</Degree>", [WSUtils URLEncode:degree.key]];
            [retString appendFormat:@"<Mode locationID=''>%@</Mode>", [WSUtils URLEncode:mode.key]];
        [retString appendFormat:@"</NameTitleLoc>"];
        [retString appendFormat:@"<Result locationID=''>"];
            [retString appendFormat:@"<Description locationID=''>%@</Description>", [WSUtils URLEncode:resultDescription]];
        [retString appendFormat:@"</Result>"];
        [retString appendFormat:@"<Cover>"];
            [retString appendFormat:@"<Rating locationID=''>%@</Rating>", [WSUtils URLEncode:cover.key]];
            [retString appendFormat:@"<Description locationID=''>%@</Description>", [WSUtils URLEncode:coverDescription]];
        [retString appendFormat:@"</Cover>"];
	[retString appendString:@"</Influence>"];
 	return [retString autorelease];
}
-(void)dealloc{
	//NSLog(@"release influence");
	[super dealloc];
	[nameTitle release];
	[contactID release];
	[roles release];
	[degree release];
	[mode release];
	[resultDescription release];
	[cover release];
}
@end
