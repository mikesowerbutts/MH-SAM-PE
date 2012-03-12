//
//  WSDataObject.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSXMLObject.h"

@interface WSDataObject : NSObject {
	NSString *ID;
	NSString *flagID;
	WSXMLObject *xmlObj;
	NSString *IDXPath;
}
@property(nonatomic, retain)NSString *ID;
@property(nonatomic, retain)NSString *IDXPath;
@property(nonatomic, retain)NSString *flagID;
@property(nonatomic, retain)WSXMLObject *xmlObj;

-(id)initWithXML:(WSXMLObject *)theXMLObj;
-(id)init;
-(NSString *)serialize;
@end
