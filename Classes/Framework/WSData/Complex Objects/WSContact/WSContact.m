//
//  Contact.m
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSContact.h"
#import "WSXMLObject.h"
#import "WSUtils.h"

@implementation WSContact
@synthesize contactFirstName, contactLastName, contactTitle, contactLocation, contactName, contactSort, contactType, contactCompany;

-(id)initWithXML:(WSXMLObject *)theXMLObj
{
	IDXPath = [[NSString alloc] initWithString:@"ContactID"];
	self = [super initWithXML:theXMLObj];
	[self initVarsSub];
	if(xmlObj != nil){
		WSXMLObject *obj = nil;
		obj = [xmlObj Get:@"ContactName"];
		self.contactName = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactFirstName"];
		self.contactFirstName = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactLastName"];
		self.contactLastName = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactSort"];
		self.contactSort = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactTitle"];
		self.contactTitle = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactCompany"];
		self.contactCompany = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactLocation"];
		self.contactLocation = [WSUtils StringFromNode:obj];
		obj = [xmlObj Get:@"ContactType"];
		self.contactType = [WSUtils StringFromNode:obj];
	}
	return self;
}
-(void)initVarsSub{
	self.contactName = [[NSString alloc] initWithString:@""];
	self.contactFirstName = [[NSString alloc] initWithString:@""];
	self.contactLastName = [[NSString alloc] initWithString:@""];
	self.contactSort = [[NSString alloc] initWithString:@""];
	self.contactTitle = [[NSString alloc] initWithString:@""];
	self.contactCompany = [[NSString alloc] initWithString:@""];
	self.contactLocation = [[NSString alloc] initWithString:@""];
	self.contactType = [[NSString alloc] initWithString:@""];
}
-(NSString *)getNameTitle{
	NSMutableString *nameTitleStr = [[NSMutableString alloc] initWithString:contactName];
	if(![contactTitle isEqualToString:@""]){
		[nameTitleStr appendFormat:@", %@", contactTitle];
	}
	return nameTitleStr;
}
-(void)dealloc
{
	[super dealloc];
	[contactFirstName release];
	[contactLastName release];
	[contactTitle release];
	[contactLocation release];
	[contactName release];
	[contactSort release];
	[contactType release];
}

@end
