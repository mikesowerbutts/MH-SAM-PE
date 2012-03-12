//
//  WSDataObject.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDataObject.h"
#import "WSXMLObject.h"
#import <objc/runtime.h>
#import "WSUtils.h"


@implementation WSDataObject
@synthesize ID, flagID, xmlObj, IDXPath;

-(id)initWithXML:(WSXMLObject *)theXMLObj
{
	xmlObj = theXMLObj;
	if(xmlObj != nil){
		WSXMLObject *IDN = [xmlObj Get:@"ID"];
		if(IDN == nil){
			IDN = [xmlObj Get:@"ContactID"];
		}
		self.ID = [WSUtils StringFromNode:IDN];
		self.flagID = [WSUtils StringFromNode:[xmlObj Get:@"FlagID"]];
	}
	else{
		self.ID = [WSUtils CreateGUID];
		self.flagID = [[NSString alloc] initWithString:@""];
	}
	return self;
}
-(id)init{
	self.ID = [WSUtils CreateGUID];
	self.flagID = [[NSString alloc] initWithString:@""];
	return self;
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<ID>%@</ID>", [WSUtils URLEncode:ID]];
	[retString appendFormat:@"<FlagID>%@</FlagID>", [WSUtils URLEncode:flagID]];
	return retString;
}
-(void)dealloc
{
	[ID release];
	[flagID release];
	[xmlObj release];
	[super dealloc];
}
@end
