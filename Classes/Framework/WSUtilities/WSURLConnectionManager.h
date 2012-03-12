//
//  WSURLConnectionManager.h
//  BlueSheet
//
//  Created by Toby Widdowson on 16/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSURLConnectionManager : NSObject {
	NSMutableDictionary *receivedData;
}
@property(nonatomic, retain)NSMutableDictionary *receivedData;
-(void)initPOST:(NSString *)url postData:(NSString *)thePostData tag:(NSString *)tag;
@end
