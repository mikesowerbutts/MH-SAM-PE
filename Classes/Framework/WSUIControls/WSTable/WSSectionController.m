    //
//  WSSectionController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 14/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSSectionController.h"
#import "WSTableViewDataController.h"
#import "WSTableView.h"
#import "WSTableViewController.h"

@implementation WSSectionController
@synthesize tableViewController, data;
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData{
	return self;
}
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData notificationType:(NSString *)theNotificationType{
	NSMutableString *notificationType = [[NSMutableString alloc] initWithString:theNotificationType];
	[notificationType appendString:@"Changed"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reBuildTable:) name:notificationType object:nil];
	return self;
}
-(id)doInit:(NSString *)theNotificationType{
	NSMutableString *notificationType = [[NSMutableString alloc] initWithString:theNotificationType];
	[notificationType appendString:@"Changed"];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reBuildTable:) name:notificationType object:nil];
	return self;
}
-(void)reBuildTable:(NSNotification *)notification{
	[self.tableViewController rebuildTable];
}
-(NSMutableArray *)BuildData{
	return nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
