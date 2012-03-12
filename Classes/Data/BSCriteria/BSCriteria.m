//
//  BSCriteria.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSCriteria.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"

@implementation BSCriteria
@synthesize value, sourceList, iccDesc;
-(id)initWithXML:(WSXMLObject *)theXMLObj SourceList:(WSKVPairList *)theSourceList ID:(NSString *)theID
{
    sourceList = theSourceList;
	[super initWithXML:theXMLObj ID:theID];
	[self initVarsSub];
	if(xmlObj != nil){
		WSXMLObject *objV = [xmlObj Get:@"Value"];
		WSXMLObject *objD = [xmlObj Get:@"Description"];
        NSString *key = [WSUtils URLDecode:[objV innerXML]];
        self.iccDesc = [WSUtils URLDecode:[objD innerXML]];
        WSKVPair *critPair = [sourceList getPairByKey:key];
        NSString *val = [WSUtils URLDecode:critPair.value];
		self.value = [[[WSKVPair alloc] initWithKeyValue:key aValue:val] autorelease];//Leak
	}
	return self;
}
-(void)initVarsSub{
	self.value = [[[WSKVPair alloc] initWithKeyValue:@"" aValue:@""] autorelease];
}
-(NSString *)serialize{
	NSMutableString *retString = [[NSMutableString alloc] initWithString:@""];
	[retString appendFormat:@"<Criteria>"];
        [retString appendFormat:@"<ID>%@</ID>", ID];
        [retString appendFormat:@"<FlagID>ICC.%@</FlagID>", ID];
        [retString appendFormat:@"<Description locationID=''>%@</Description>", [WSUtils URLEncode:self.iccDesc]];
        [retString appendFormat:@"<Value locationID=''>%@</Value>", [WSUtils URLEncode:self.value.key]];
	[retString appendString:@"</Criteria>"];
	return [retString autorelease];
}
-(id)copyObject{
	BSCriteria *cri = [[BSCriteria alloc] initWithXML:nil ID:dataID];
	cri.ID = self.ID;
	cri.dataID = self.dataID;
	cri.flagID = self.flagID;
    cri.iccDesc = self.iccDesc;
	cri.value = self.value;
	return cri;
}
-(void)dealloc{
	[super dealloc];
    [iccDesc release];
	[value release];
}
@end
