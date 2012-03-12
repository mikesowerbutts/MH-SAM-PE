    //
//  WSTableViewGroupController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 27/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTableViewGroupController.h"


@implementation WSTableViewGroupController
@synthesize tableViews;

-(id)initWithTableViews:(NSMutableArray *)theTableViews{
	tableViews = theTableViews;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollGroupedTables:) name:@"tableScroll" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectRowsOnGroupedTables:) name:@"tableRowSelected" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRowsToGroup:) name:@"tableAddRow" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteRowsFromGroup:) name:@"tableDeleteRow" object:nil];
	return self;
}
-(BOOL)findTableController:(NSNotification *) notification{
	WSTableViewController *stc = (WSTableViewController*)[notification object];
	BOOL found = NO;
	for(int i = 0; i < [tableViews count]; i++){
		if([tableViews objectAtIndex:i] == stc){
			found = YES;
		}
	}
	return found;
}
-(void)deleteRowsFromGroup:(NSNotification *) notification{
	if([self findTableController:notification]){
		WSTableViewController *stc = (WSTableViewController*)[notification object];
		for(int i = 0; i < [tableViews count]; i++){
			WSTableViewController *tc = [tableViews objectAtIndex:i];
			if(stc != tc){
				[tc deleteSelectedRow:@"GROUP"];
			}
		}
	}
}

-(void)addRowsToGroup:(NSNotification *) notification{
	if([self findTableController:notification]){
		WSTableViewController *stc = (WSTableViewController*)[notification object];
		for(int i = 0; i < [tableViews count]; i++){
			WSTableViewController *tc = [tableViews objectAtIndex:i];
			if(stc != tc){
				[tc addEmptyRow];
			}
		}
	}
}
-(void)scrollGroupedTables:(NSNotification *) notification{
	if([self findTableController:notification]){
		WSTableViewController *stc = (WSTableViewController*)[notification object];
		for(int i = 0; i < [tableViews count]; i++){
			WSTableViewController *tc = [tableViews objectAtIndex:i];
			if(stc != tc){
				[tc.tableView setContentOffset:CGPointMake(stc.tableView.contentOffset.x, stc.tableView.contentOffset.y)];
			}
		}
	}
}

-(void)selectRowsOnGroupedTables:(NSNotification *)notification{
	if([self findTableController:notification]){
		WSTableViewController *stc = (WSTableViewController*)[notification object];
		for(int i = 0; i < [tableViews count]; i++){
			WSTableViewController *tc = [tableViews objectAtIndex:i];
			if(stc != tc){
				[tc doDeselectRowAtIndexPath:[tc.tableView indexPathForSelectedRow]];
				[tc.tableView selectRowAtIndexPath:[stc.tableView indexPathForSelectedRow] animated:NO scrollPosition:UITableViewScrollPositionNone];
			}
		}
	}
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
