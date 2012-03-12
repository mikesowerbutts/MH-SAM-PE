//
//  BuyingInfluences_Involved_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 27/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Involved_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BuyingInfluences_Involved_Dialog_Controller.h"
#import "BlueSheetDataModel.h"
#import "BSInfluenceInvolvedDataPicker.h"
#import "WSTableViewDataController.h"
#import "BuyingInfluences_Involved_TableViewController.h"

@implementation BuyingInfluences_Involved_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Influence" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:60 columnHeader:@"Name, Title, Location" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:13.3 columnHeader:@"IR" columnTextAlign:UITextAlignmentCenter] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:13.3 columnHeader:@"DI" columnTextAlign:UITextAlignmentCenter] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:13.4 columnHeader:@"M" columnTextAlign:UITextAlignmentCenter] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSInfluenceInvolvedDataPicker alloc] initWithList:[[bluesheetDataModel getInfluences] items] ID:ID] autorelease]];
	self.tableViewController = [[[BuyingInfluences_Involved_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"BUYING INFLUENCES INVOLVED" groupMode:@"MASTER" showColHeaders:YES ID:ID] autorelease];//Leak
	[self.tableViewController setFlagOffset:0];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/BuyingInfluences"] GetAttribute:@"url"];
    [colTypes release];
    [dataCon release];
	return self;
}
@end
