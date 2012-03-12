//
//  BestActionPlan_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 03/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BestActionPlan_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BSActionBestActionsDataPicker.h"
#import "BlueSheetDataModel.h"
#import "WSTableViewDataController.h"
#import "BestActionPlan_TableViewController.h"
#import "BlueSheetViewController.h"

@implementation BestActionPlan_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Action" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:50 columnHeader:@"Description" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:30 columnHeader:@"Contact" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"DATE" columnWidth:20 columnHeader:@"When" columnTextAlign:UITextAlignmentLeft] autorelease]];
	WSTableViewDataController *dataCon = [[[WSTableViewDataController alloc] initWithPicker:[[[BSActionBestActionsDataPicker alloc] initWithList:[[bluesheetDataModel getActions] items] ID:ID] autorelease]] autorelease];
	self.tableViewController = [[[BestActionPlan_TableViewController alloc] initWithColsAndTable:dataCon readOnly:YES multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"BEST ACTION PLAN" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
    [colTypes release];
	tableViewController.mode = @"NORMAL";
	tableViewController.selectable = NO;
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/BestActions"] GetAttribute:@"url"];
    tableViewController.canFullScreen = YES;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkReBuildTable:) name:@"tableDeleteRow" object:nil];
	return self;
}
-(void)checkReBuildTable:(NSNotification *)notification{
    BlueSheetViewController *bsVC = (BlueSheetViewController *)self.tableViewController.delegate;
    if([notification object] == bsVC.possActions_Controller.tableViewController){
        [self reBuildTable:notification];
    }
}
@end
