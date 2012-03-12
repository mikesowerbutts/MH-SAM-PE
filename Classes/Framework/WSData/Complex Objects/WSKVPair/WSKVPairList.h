//
//  WSKVPairList.h
//  BlueSheet
//
//  Created by Toby Widdowson on 13/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSKVPair.h"
#import "WSXMLObject.h"

@interface WSKVPairList : NSObject {
	NSMutableArray *items;
}
@property(nonatomic, retain)NSMutableArray *items;
-(id)initWithXMLNode:(WSXMLObject *)theXMLObj;
-(void)setupVars;
-(WSKVPair *)getPairByKey:(NSString *)key;
-(WSKVPairList *)getPairListByValue:(NSString *)value;
-(NSMutableArray *)getValues;
-(NSMutableArray *)getKeys;
-(NSMutableArray *)getKeysValues;
-(WSKVPairList *)mutableCopy;
-(void)removePairByKey:(NSString *)key;
@end
