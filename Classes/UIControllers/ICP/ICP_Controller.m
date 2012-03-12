    //
//  ICP_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 02/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "ICP_Controller.h"
#import "WSColumnInfo.h"
#import "WSPopoverViewController.h"
#import "BlueSheetDataModel.h"
#import "BSCriteriaDataPicker.h"
#import "WSTableViewDataController.h"
#import "ICP_Dialog_Controller.h"
#import "ICPTableViewController.h"
@implementation ICP_Controller
-(id)doInit:(WSTableView *)theTable ID:(NSString *)theID
{
	[super doInit:theTable data:nil notificationType:@"ICP" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"NUMBER" columnWidth:10 columnHeader:@" " columnTextAlign:UITextAlignmentCenter] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:70 columnHeader:@"Ideal Customer Criteria" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"NUMBER" columnWidth:20 columnHeader:@"Rating" columnTextAlign:UITextAlignmentCenter] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSCriteriaDataPicker alloc] initWithList:[[bluesheetDataModel getCriterias] items] ID:ID] autorelease]];
	self.tableViewController = [[[ICPTableViewController alloc] initWithColsAndTable:dataCon readOnly:YES multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"IDEAL CUSTOMER PROFILE" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = YES;
	tableViewController.sortable = NO;
	tableViewController.tableView.scrollEnabled = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/IdealCustomerCriteria"] GetAttribute:@"url"];
    [colTypes release];
    [dataCon release];
	return self;
}
-(void)dealloc{
	[super dealloc];
}
@end
