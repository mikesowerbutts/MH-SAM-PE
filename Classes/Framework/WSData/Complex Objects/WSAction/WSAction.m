//
//  WSAction.m
//  BlueSheet
//
//  Created by Toby Widdowson on 07/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSAction.h"
#import "WSUtils.h"
#import "WSDataModel.h"

@implementation WSAction
@synthesize what, whoID, ownerID, when, completed, status, type, check, taskID;
-(id)initWithXML:(WSXMLObject *)theXMLObj
{
	self = [super initWithXML:theXMLObj];
	[self initVarsSub];
	if(xmlObj != nil){
		WSXMLObject *obj = [xmlObj Get:@"What"];
		WSXMLObject *obj2 = [xmlObj Get:@"What"];
		self.what = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"Who"];
		NSString *str = [obj GetAttribute:@"contactID"];
		self.whoID = (str != nil) ? str : @"";
		obj = [xmlObj Get:@"Owner"];
		str = [obj GetAttribute:@"contactID"];
		self.ownerID = (str != nil) ? str : @"";
		obj = [xmlObj Get:@"When"];
		[self setWhenWithString:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"Completed"];
		[self setCompletedWithString:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"Status"];
		obj2 = [xmlObj Get:@"StatusLabel"];
		self.status = [[WSKVPair alloc] initWithKeyValue:[WSUtils StringFromNode:obj] aValue:[WSUtils StringFromNode:obj2]];
		obj = [xmlObj Get:@"Type"];
		obj2 = [xmlObj Get:@"TypeLabel"];
		self.type = [[WSKVPair alloc] initWithKeyValue:[WSUtils StringFromNode:obj] aValue:[WSUtils StringFromNode:obj2]];
		str = [xmlObj GetAttribute:@"check"];
		[self setCheckWithString:(str != nil) ? str : @""];
		str = [xmlObj GetAttribute:@"TaskID"];
		self.taskID = (str != nil) ? str : @"";
	}
	return self;
}
-(void)initVarsSub{
	self.what = [[NSString alloc] initWithString:@""];
	self.whoID = [[NSString alloc] initWithString:@""];
	self.ownerID = [[NSString alloc] initWithString:@""];
	self.when = [[WSDate alloc] initWithString:@""];
	self.completed = [[WSDate alloc] initWithString:@""];
	self.status = [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
	self.type = [[WSKVPair alloc] initWithKeyValue:@"" aValue:@""];
	self.check = [[WSBoolean alloc] initWithString:@""];
	self.taskID = [[NSString alloc] initWithString:@""];
}
-(void)setWhenWithString:(NSString *)newWhen{
	[when release];
	when = [[[WSDate alloc] initWithString:newWhen] retain];
}
-(void)setCompletedWithString:(NSString *)newCompleted{
	[completed release];
	completed = [[[WSDate alloc] initWithString:newCompleted] retain];
}
-(void)setCheckWithString:(NSString *)newCheck{
	[check release];
	check = [[[WSBoolean alloc] initWithString:newCheck] retain];
}
-(WSContact *)getWhoContact{
	WSContact *con = [[[WSDataModel instance] getContacts] getContactByID:self.whoID];
	if(con == nil){
		con = [[WSContact alloc] initWithXML:nil];
	}
	return con;
}
-(WSContact *)getOwnerContact{
	WSContact *con = [[[WSDataModel instance] getContacts] getContactByID:self.ownerID];
	if(con == nil){
		con = [[WSContact alloc] initWithXML:nil];
	}
	return con;
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<Action check='%@' TaskID='%@'>", [check numberValue], taskID];
	[retString appendString:[super serialize]];
	[retString appendFormat:@"<What>%@</What>", [WSUtils URLEncode:what]];
	[retString appendFormat:@"<Who contactID='%@' contactName='%@'>%@</Who>", 
	 self.whoID != nil ? [WSUtils URLEncode:whoID] : @"", 
	 self.whoID != nil ? [WSUtils URLEncode:[self getWhoContact].contactName] : @"", 
	 self.whoID != nil ? [WSUtils URLEncode:[self getWhoContact].contactName] : @""];
	[retString appendFormat:@"<Owner contactID='%@' contactName='%@'>%@</Owner>", 
	 self.ownerID != nil ? [WSUtils URLEncode:self.ownerID] : @"",
	 self.ownerID != nil ? [WSUtils URLEncode:[self getOwnerContact].contactName] : @"",
	 self.ownerID != nil ? [WSUtils URLEncode:[self getOwnerContact].contactName] : @""];
	[retString appendFormat:@"<When>%@</When>", [when getXMLFormattedDate]];
	[retString appendFormat:@"<Completed>%@</Completed>", [completed getXMLFormattedDate]];
	[retString appendFormat:@"<Status>%@</Status>", [WSUtils URLEncode:status.key]];
	[retString appendFormat:@"<StatusLabel>%@</StatusLabel>", [WSUtils URLEncode:status.value]];
	[retString appendFormat:@"<Type>%@</Type>", [WSUtils URLEncode:type.key]];
	[retString appendFormat:@"<TypeLabel>%@</TypeLabel>", [WSUtils URLEncode:type.value]];
	[retString appendString:@"</Action>"];
	return [retString autorelease];
}
-(id)copyObject{
	WSAction *act = [[WSAction alloc] initWithXML:nil];
	act.ID = ID;
	act.flagID = flagID;
	act.what = what;
	act.whoID = whoID;
	act.ownerID = ownerID;
	act.when = when;
	act.completed = completed;
	act.status = status;
	act.type = type;
	act.check = check;
	act.taskID = taskID;
	return act;
}
-(void)dealloc{
	NSLog(@"action dealloc");
	[super dealloc];
	[what release];
	[whoID release];
	[ownerID release];
	[completed release];
	[status release];
	[type release];
	[check release];
	[taskID release];
}
@end
