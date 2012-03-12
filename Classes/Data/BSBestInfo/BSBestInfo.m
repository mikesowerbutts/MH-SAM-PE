//
//  BSBestInfo.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSBestInfo.h"
#import "WSUtils.h"

@implementation BSBestInfo
@synthesize sourceDescription;
-(id)initWithBSBestInfo:(BSBestInfo *)obj{
	BSBestInfo *retObj = [[BSBestInfo alloc] initWithXML:[[[WSXMLObject alloc] init:[obj serialize]] autorelease] ID:obj.dataID];
	return retObj;
}

-(id)initWithXML:(WSXMLObject *)theXMLObj ID:(NSString *)theID{
	[super initWithXML:theXMLObj ID:theID];
	//[self initVarsSub];
	self.xmlObj = theXMLObj;
	if(xmlObj != nil){
		WSXMLObject *obj = [xmlObj Get:@"Information"];
		WSXMLObject *obj2 = [xmlObj Get:@"Information"];
		NSString *str = [[NSString alloc] initWithString:@""];
		self.what = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"SourceDescription"];
		self.sourceDescription = [WSUtils StringFromNode:obj];
        if(self.sourceDescription == nil)
            self.sourceDescription = [[[NSString alloc] initWithString:@""] autorelease];
		obj = [xmlObj Get:@"Source"];
		str = [obj GetAttribute:@"contactID"];
		self.whoID = (str != nil) ? str : @"";
		obj = [xmlObj Get:@"Whom"];
		str = [obj GetAttribute:@"contactID"];
		self.ownerID = (str != nil) ? str : @"";
		obj = [xmlObj Get:@"When"];
		[self setWhenWithString:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"Completed"];
		[self setCompletedWithString:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"Status"];
		obj2 = [xmlObj Get:@"StatusLabel"];
		self.status = [[[WSKVPair alloc] initWithKeyValue:[WSUtils StringFromNode:obj] aValue:[WSUtils StringFromNode:obj2]] autorelease];
		obj = [xmlObj Get:@"Type"];
		obj2 = [xmlObj Get:@"TypeLabel"];
		self.type = [[[WSKVPair alloc] initWithKeyValue:[WSUtils StringFromNode:obj] aValue:[WSUtils StringFromNode:obj2]] autorelease];		
		str = [xmlObj GetAttribute:@"check"];
		[self setCheckWithString:str != nil ? str : @""];
		str = [xmlObj GetAttribute:@"TaskID"];
		self.taskID = str != nil ? str : @"";
	}
	return self;
}
-(void)initVarsSub{
	[super initVarsSub];
	self.sourceDescription = [[[NSString alloc] initWithString:@""] autorelease];
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<BestInfo check='%@' TaskID='%@'>", [self.check numberValue], self.ID];
        [retString appendFormat:@"<ID>%@</ID>", self.ID];
        [retString appendFormat:@"<Information>%@</Information>", [WSUtils URLEncode:self.what]];
        [retString appendFormat:@"<SourceDescription>%@</SourceDescription>", [WSUtils URLEncode:self.sourceDescription ]];
        [retString appendFormat:@"<Whom contactID='%@' contactName='%@'>%@</Whom>", 
         self.whoID != nil ? [WSUtils URLEncode:self.whoID] : @"", 
         self.whoID != nil ? [WSUtils URLEncode:[self getWhoContact].contactName] : @"", 
         self.whoID != nil ? [WSUtils URLEncode:[self getWhoContact].contactName] : @""];
        [retString appendFormat:@"<Source contactID='%@' contactName='%@'>%@</Source>", 
         self.ownerID != nil ? [WSUtils URLEncode:self.ownerID] : @"",
         self.ownerID != nil ? [WSUtils URLEncode:[self getOwnerContact].contactName] : @"",
         self.ownerID != nil ? [WSUtils URLEncode:[self getOwnerContact].contactName] : @""];
        [retString appendFormat:@"<When>%@</When>", [self.when getXMLFormattedDate]];
        [retString appendFormat:@"<Completed>%@</Completed>", [self.completed getXMLFormattedDate]];
        [retString appendFormat:@"<Status>%@</Status>", [WSUtils URLEncode:self.status.key]];
        [retString appendFormat:@"<StatusLabel>%@</StatusLabel>", [WSUtils URLEncode:self.status.value]];
	[retString appendString:@"</BestInfo>"];
	return [retString autorelease];
}
-(id)copyWithZone:(NSZone *)zone{
	BSBestInfo *copy = [[[self class] allocWithZone:zone] initWithBSBestInfo:self];
	return copy;
}
-(void)dealloc{
    [sourceDescription release];
	[super dealloc];
}
@end
