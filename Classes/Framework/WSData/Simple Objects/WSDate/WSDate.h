//
//  WSDate.h
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSDate : NSObject {
	NSString *rawDate;
	NSDate *date;
	NSDateFormatter *dateFormatter;
}
@property(nonatomic, retain)NSString *rawDate;
@property(nonatomic, retain)NSDate *date;
@property(nonatomic, retain)NSDateFormatter *dateFormatter;

-(NSString *)getFormattedDate;
-(NSString *)getXMLFormattedDate;
-(id)initWithString:(NSString *)dateStr;
@end
