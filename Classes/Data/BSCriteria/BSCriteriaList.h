//
//  BSCriteriaList.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObjectList.h"
#import "BSCriteria.h"

@interface BSCriteriaList : WSDataObjectList {
    WSKVPairList *sourceList;
}
@property(nonatomic, retain)WSKVPairList *sourceList;


-(id)init:(WSXMLObject *)theData sourceList:(WSKVPairList *)theSourceList ID:(NSString *)theID;
@end
