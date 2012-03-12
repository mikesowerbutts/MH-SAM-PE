//
//  WSKVPair.h
//  BlueSheet
//
//  Created by Toby Widdowson on 13/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSKVPair : NSObject {
	NSString *key;
	NSString *value;
	NSMutableData *dataValue;
	NSObject *objectValue;
}
@property(nonatomic, retain)NSString *key;
@property(nonatomic, retain)NSString *value;
@property(nonatomic, retain)NSMutableData *dataValue;
@property(nonatomic, retain)NSObject *objectValue;
-(id)initWithKeyValue:(NSString *)theKey aValue:(NSString *)theValue;
-(id)initWithKeyDataValue:(NSString *)theKey aValue:(NSMutableData *)theValue;
-(id)initWithKeyObjectValue:(NSString *)theKey aObject:(NSObject *)theValue;
-(id)copyObject;
@end
