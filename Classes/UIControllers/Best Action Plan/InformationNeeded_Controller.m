//
//  InformationNeeded_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 03/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "InformationNeeded_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BSBestInfoDataPicker.h"
#import "BlueSheetDataModel.h"
#import "WSTableViewDataController.h"
#import "InformationNeeded_Dialog_Controller.h"
#import "InformationNeeded_TableViewController.h"

@implementation InformationNeeded_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"BestInfo" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:50 columnHeader:@"What" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:30 columnHeader:@"Assigned To" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"DATE" columnWidth:20 columnHeader:@"When" columnTextAlign:UITextAlignmentLeft] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSBestInfoDataPicker alloc] initWithList:[[bluesheetDataModel getBestInfos] items] ID:ID] autorelease]];
	self.tableViewController = [[[InformationNeeded_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"Information Needed" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
    [dataCon release];
    [colTypes release];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
	return self;
}
-(void)dealloc{
    [super dealloc];
}
@end
