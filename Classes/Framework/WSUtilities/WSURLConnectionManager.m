//
//  WSURLConnectionManager.m
//  BlueSheet
//
//  Created by Toby Widdowson on 16/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSURLConnectionManager.h"
#import "WSURLConnection.h"
#import "WSKVPair.h"

@implementation WSURLConnectionManager
@synthesize receivedData;
-(id)init{
	self.receivedData = [[NSMutableDictionary alloc] init];
	return self;
}
-(void)initPOST:(NSString *)url postData:(NSString *)thePostData tag:(NSString *)tag{
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[thePostData dataUsingEncoding:NSISOLatin1StringEncoding]];
	WSURLConnection *connection = [[WSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES tag:tag];
	if(connection){
		[receivedData setObject:[[NSMutableData data] retain] forKey:connection.tag];
	}
}
-(NSMutableData *)dataForConnection:(WSURLConnection *)connection{
	NSMutableData *data = [receivedData objectForKey:connection.tag];
	return data;
}
-(void)connection:(NSURLConnection *)connection didReceivedResponse:(NSURLResponse *)response{
	NSMutableData *dataForConnection = [self dataForConnection:(WSURLConnection *)connection];
	[dataForConnection setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	NSMutableData *dataForConnection = [self dataForConnection:(WSURLConnection *)connection];
	[dataForConnection appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	WSURLConnection *conn = (WSURLConnection *)connection;
	NSMutableData *dataForConnection = [self dataForConnection:conn];
	[connection release];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFinishedLoading" object:[[WSKVPair alloc] initWithKeyDataValue:conn.tag aValue:dataForConnection]];
}
@end
