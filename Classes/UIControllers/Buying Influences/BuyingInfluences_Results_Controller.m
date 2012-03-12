//
//  BuyingInfluences_Results_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 27/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Results_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"
#import "BSInfluenceResultsDataPicker.h"
#import "BuyingInfluences_Results_Dialog_Controller.h"
#import "WSTableViewDataController.h"
#import "BuyingInfluences_Results_TableViewController.h"

@implementation BuyingInfluences_Results_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Influence" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] init:@"STRING" columnWidth:100 columnHeader:@" "] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSInfluenceResultsDataPicker alloc] initWithList:[[bluesheetDataModel getInfluences] items] ID:ID] autorelease]];
	self.tableViewController = [[[BuyingInfluences_Results_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"BUYING INFLUENCE'S KEY WIN - RESULTS" groupMode:@"GROUP" showColHeaders:YES ID:ID] autorelease];//Leak
	[self.tableViewController setFlagOffset:4];
	tableViewController.mode = @"NORMAL";
	tableViewController.groupMode = @"GROUP";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/BuyingInfluencesKeyWin"] GetAttribute:@"url"];
    [colTypes release];
    [dataCon release];
	return self;
}
@end
