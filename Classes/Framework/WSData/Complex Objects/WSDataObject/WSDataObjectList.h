//
//  ObjectList.h
//  BlueSheet
//
//  Created by Toby Widdowson on 14/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSXMLObject.h"

@interface WSDataObjectList : NSObject {
	WSXMLObject *data;
	NSMutableArray *items;
	NSString *xmlNodeName;
}
@property(nonatomic, retain)NSMutableArray *items;
@property(nonatomic, retain)NSString *xmlNodeName;
-(id)init:(WSXMLObject *)theData;

-(id)getObjectByID:(NSString *)theID;
-(void)buildList;
-(void)removeObjectByID:(NSString *)theID;
-(NSString *)serializeObjects;
@end
