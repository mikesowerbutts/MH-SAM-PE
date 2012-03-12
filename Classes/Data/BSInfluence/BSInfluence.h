//
//  BSInfluence.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"
#import "WSKVPair.h"
#import "WSContact.h"

@interface BSInfluence : WSDataObject {
	NSString *contactID;
	NSString *nameTitle;
	WSKVPairList *roles;
	WSKVPair *degree;
	WSKVPair *mode;
	NSString *resultDescription;
	WSKVPair *cover;
	NSString *coverDescription;
}
@property(nonatomic, retain)NSString *contactID;
@property(nonatomic, retain)NSString *nameTitle;
@property(nonatomic, retain)WSKVPairList *roles;
@property(nonatomic, retain)WSKVPair *degree;
@property(nonatomic, retain)WSKVPair *mode;
@property(nonatomic, retain)NSString *resultDescription;
@property(nonatomic, retain)WSKVPair *cover;
@property(nonatomic, retain)NSString *coverDescription;
-(BSInfluence *)copyObject;
-(void)initVarsSub;
-(void)setTheContactID:(NSString *)newContactID;
@end
