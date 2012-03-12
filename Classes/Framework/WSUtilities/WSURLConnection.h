//
//  WSURLConnection.h
//  BlueSheet
//
//  Created by Toby Widdowson on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSURLConnection : NSURLConnection {
	NSString *tag;
	NSData *receivedData;
}
@property(nonatomic, retain)NSString *tag;
-(id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately tag:(NSString *)tag;
@end
