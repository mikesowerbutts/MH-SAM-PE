//
//  WSAction.h
//  BlueSheet
//
//  Created by Toby Widdowson on 07/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"
#import "WSContact.h"
#import "WSBoolean.h"
#import "WSDate.h"
#import "WSKVPair.h"

@interface WSAction : WSDataObject {
	WSBoolean *check;
	NSString *taskID;
	NSString *what;
	NSString *whoID;
	NSString *ownerID;
	WSDate *when;
	WSDate *completed;
	WSKVPair *status;
	WSKVPair *type;
}
@property(nonatomic, retain)WSBoolean *check;
@property(nonatomic, retain)NSString *taskID;
@property(nonatomic, retain)NSString *what;
@property(nonatomic, retain)NSString *whoID;
@property(nonatomic, retain)NSString *ownerID;
@property(nonatomic, retain)WSDate *when;
@property(nonatomic, retain)WSDate *completed;
@property(nonatomic, retain)WSKVPair *status;
@property(nonatomic, retain)WSKVPair *type;
-(id)initWithXML:(WSXMLObject *)theXMLObj;
-(void)setCheckWithString:(NSString *)newCheck;
-(void)setWhenWithString:(NSString *)newWhen;
-(void)setCompletedWithString:(NSString *)newCompleted;
-(void)initVarsSub;
-(WSContact *)getWhoContact;
-(WSContact *)getOwnerContact;
@end
