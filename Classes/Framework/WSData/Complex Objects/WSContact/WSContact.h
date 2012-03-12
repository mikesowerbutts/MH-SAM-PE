//
//  Contact.h
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"

@interface WSContact : WSDataObject {
	NSString *contactName;
	NSString *contactFirstName;
	NSString *contactLastName;
	NSString *contactSort;
	NSString *contactType;
	NSString *contactCompany;
	NSString *contactTitle;
	NSString *contactLocation;
}
@property(nonatomic, retain)NSString *contactFirstName;
@property(nonatomic, retain)NSString *contactLastName;
@property(nonatomic, retain)NSString *contactTitle;
@property(nonatomic, retain)NSString *contactLocation;
@property(nonatomic, retain)NSString *contactName;
@property(nonatomic, retain)NSString *contactCompany;
@property(nonatomic, retain)NSString *contactSort;
@property(nonatomic, retain)NSString *contactType;

-(void)initVarsSub;
-(NSString *)getNameTitle;
@end
