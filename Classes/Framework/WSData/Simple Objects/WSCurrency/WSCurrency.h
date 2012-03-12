//
//  WSCurrency.h
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSCurrency : NSObject {
	NSString *rawValue;
	NSNumberFormatter *numFormatter;
	NSString *thouSep;
	NSString *decSep;
	NSString *symbol;
}
@property(nonatomic, retain)NSString *rawValue;
@property(nonatomic, retain)NSString *thouSep;
@property(nonatomic, retain)NSString *decSep;
@property(nonatomic, retain)NSString *symbol;
@property(nonatomic, retain)NSNumberFormatter *numFormatter;
-(id)initWithString:(NSString *)theValue;
-(NSString *)getFormattedValue;
@end
