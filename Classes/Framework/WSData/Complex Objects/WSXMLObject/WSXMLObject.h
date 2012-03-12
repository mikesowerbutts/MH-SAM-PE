//
//  WSXMLObject.h
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSXMLObject : NSObject {
	NSString *name;
	NSString *innerXML;
	NSString *outerXML;
	NSMutableDictionary *children;
	NSMutableDictionary *attributes;
	WSXMLObject *parent;
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *innerXML;
@property(nonatomic,retain)NSString *outerXML;
@property(nonatomic,retain)NSMutableDictionary *children;
@property(nonatomic,retain)NSMutableDictionary *attributes;
@property(nonatomic,retain)WSXMLObject *parent;

-(id)init:(NSString *)theXML;
-(id)Get:(NSString *)objName;
-(id)GetByIndex:(NSUInteger)idx;
-(NSString *)GetAttribute:(NSString *)attName;
-(NSString *)GetAttributeByIndex:(NSUInteger)idx;
-(NSMutableArray *)GetChildAttributesByName:(NSString *)attName;
-(void)SetAttribute:(NSString *)attName newAttValue:(NSString *)newValue;
-(void)RefreshXMLProperties;
-(void)ReplaceChildNode:(NSString *)theXPathToChildNode replacementNode:(WSXMLObject *)theReplacementNode;
-(WSXMLObject *)GetByAttributeValue:(NSString *)attName attValue:(NSString *)attValue;
@end
