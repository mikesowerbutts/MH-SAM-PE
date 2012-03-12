//
//  WSBoolean.h
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSBoolean : NSObject {
	NSString *rawValue;
	BOOL value;
}
@property(nonatomic, retain)NSString *rawValue;
@property(nonatomic)BOOL value;

-(NSString *)numberValue;
-(NSString *)stringValue;
@end
