//
//  BSStrength.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSStrength.h"
#import "WSUtils.h"


@implementation BSStrength
@synthesize description;
-(id)initWithXML:(WSXMLObject *)theXMLObj ID:(NSString *)theID{
	self = [super initWithXML:theXMLObj ID:theID];
	[self initVarsSub];
	if(xmlObj != nil){
		WSXMLObject *obj = [xmlObj Get:@"Description"];
		self.description = [WSUtils StringFromNode:obj];
	}
	return self;
}
-(void)initVarsSub{
	self.description = [[[NSString alloc] initWithString:@""] autorelease];
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<Strength>"];
        [retString appendString:[super serialize]];
        [retString appendFormat:@"<Description>%@</Description>", [WSUtils URLEncode:self.description]];
	[retString appendString:@"</Strength>"];
	return [retString autorelease];
}
-(id)copyObject{
	BSStrength *strCopy = [[BSStrength alloc] initWithXML:nil ID:dataID];
	strCopy.ID = self.ID;
	strCopy.dataID = self.dataID;
	strCopy.flagID = self.flagID;
	strCopy.description = self.description;
	return strCopy;
}
-(void)dealloc{
	[super dealloc];
	[description release];
}
@end
