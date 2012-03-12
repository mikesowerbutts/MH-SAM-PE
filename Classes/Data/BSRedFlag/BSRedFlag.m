//
//  BSRedFlag.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSRedFlag.h"
#import "WSUtils.h"


@implementation BSRedFlag
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
	self.description = [[[NSString alloc] initWithString:@""] autorelease];//Leak
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<RedFlag>"];
        [retString appendString:[super serialize]];
        [retString appendFormat:@"<Description>%@</Description>", [WSUtils URLEncode:self.description]];
	[retString appendString:@"</RedFlag>"];
	return [retString autorelease];//Leak
}
-(id)copyObject{
	BSRedFlag *rfCopy = [[BSRedFlag alloc] initWithXML:nil ID:dataID];
	rfCopy.ID = self.ID;
	rfCopy.dataID = self.dataID;
	rfCopy.flagID = self.flagID; 
	rfCopy.description = self.description;
	return rfCopy;
}
-(void)dealloc{
	[super dealloc];
	[description release];
}
@end
