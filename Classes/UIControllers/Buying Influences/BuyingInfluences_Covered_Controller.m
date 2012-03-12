//
//  BuyingInfluences_Covered_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 27/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Covered_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"
#import "BSInfluenceCoveredDataPicker.h"
#import "WSTableViewDataController.h"
#import "BuyingInfluences_Covered_Dialog_Controller.h"
#import "MHTableViewController.h"
#import "BuyingInfluences_Covered_TableViewController.h"
@implementation BuyingInfluences_Covered_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Influence" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"NUMBER" columnWidth:15 columnHeader:@"Rating" columnTextAlign:UITextAlignmentCenter] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:85 columnHeader:@"Description" columnTextAlign:UITextAlignmentLeft] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSInfluenceCoveredDataPicker alloc] initWithList:[[bluesheetDataModel getInfluences] items] ID:ID] autorelease]];
	self.tableViewController = [[[BuyingInfluences_Covered_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"HOW WELL IS BASE COVERED?" groupMode:@"GROUP" showColHeaders:YES ID:ID] autorelease];
    [dataCon release];
    [colTypes release];
	[self.tableViewController setFlagOffset:5];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/BuyingInfluencesBase"] GetAttribute:@"url"];
	return self;
}
@end
