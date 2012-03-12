//
//  BSCriteria.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"
#import "WSKVPair.h"
@interface BSCriteria : WSDataObject {
    NSString *iccDesc;
	WSKVPair *value;
    WSKVPairList *sourceList;
}
@property(nonatomic, retain)NSString *iccDesc;
@property(nonatomic, retain)WSKVPair *value;
@property(nonatomic, retain)WSKVPairList *sourceList;

-(id)initWithXML:(WSXMLObject *)theXMLObj SourceList:(WSKVPairList *)theSourceList ID:(NSString *)theID;
-(void)initVarsSub;
-(id)copyObject;
@end
