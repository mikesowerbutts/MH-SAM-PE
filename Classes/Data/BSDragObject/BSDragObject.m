//
//  BSDragObject.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSDragObject.h"
#import "WSUtils.h"
#import "WSXMLObject.h"

@implementation BSDragObject
@synthesize xRatio, yRatio, type;
-(id)initWithXML:(WSXMLObject *)theXMLObj ID:(NSString *)theID{
	[super initWithXML:theXMLObj ID:theID];
	if(xmlObj != nil){
		WSXMLObject *obj = [xmlObj Get:@"XRatio"];
		self.xRatio = [WSUtils URLDecode:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"YRatio"];
		self.yRatio = [WSUtils URLDecode:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"Type"];
		self.type = [WSUtils URLDecode:[WSUtils StringFromNode:obj]];
		obj = [xmlObj Get:@"FlagID"];
		self.ID = [WSUtils URLDecode:[WSUtils StringFromNode:obj]];
	}
	else
		[self initVarsSub];
	return self;
}
-(id)initWithProps:(NSString *)theID xRatio:(NSString *)theXRatio yRatio:(NSString *)theYRatio type:(NSString *)theType{
	self.ID = theID;
	self.xRatio = theXRatio;
	self.yRatio = theYRatio;
	self.type = theType;
	return self;
}
-(void)initVarsSub{
	self.ID = @"";
	self.xRatio = @"";
	self.yRatio = @"";
	self.type = @"";
}
-(NSString *)getImage{
	if([type isEqualToString:@"redflag"])
		return @"redflag.png";
	else if([type isEqualToString:@"barbell"])
		return @"barbell.png";
	return @"";
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] init];
	[retString appendFormat:@"<Flag>"];
	[retString appendFormat:@"<FlagID>%@</FlagID>", [WSUtils URLEncode:ID]];
	[retString appendFormat:@"<XRatio>%@</XRatio>", [WSUtils URLEncode:xRatio]];
	[retString appendFormat:@"<YRatio>%@</YRatio>", [WSUtils URLEncode:yRatio]];
	[retString appendFormat:@"<Type>%@</Type>", [WSUtils URLEncode:type]];
	[retString appendFormat:@"</Flag>"];
	return [retString autorelease];
}
-(id)copyWithZone:(NSZone *)zone{
    BSDragObject *copy = [[BSDragObject alloc] initWithProps:self.ID xRatio:self.xRatio yRatio:self.yRatio type:self.type];
    return copy;
}
-(void)dealloc{
	[super dealloc];
	[xRatio release];
	[yRatio release];
	[type release];
}
@end
