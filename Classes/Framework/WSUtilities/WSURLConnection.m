//
//  WSURLConnection.m
//  BlueSheet
//
//  Created by Toby Widdowson on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSURLConnection.h"


@implementation WSURLConnection
@synthesize tag;
-(id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately tag:(NSString *)tag{
	self = [super initWithRequest:request delegate:delegate startImmediately:startImmediately];
	if(self){
		self.tag = tag;
	}
	return self;
}
-(void)dealloc{
	[tag release];
	[super dealloc];
}
@end
