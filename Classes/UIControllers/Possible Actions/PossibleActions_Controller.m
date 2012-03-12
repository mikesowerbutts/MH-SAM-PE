//
//  PossibleActions_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 03/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "PossibleActions_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"
#import "BSActionPossibleActionsDataPicker.h"
#import "WSTableViewDataController.h"
#import "PossibleActions_Dialog_Controller.h"
#import "PossibleActionsTableViewController.h"

@implementation PossibleActions_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Action" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:30 columnHeader:@"Description" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:30 columnHeader:@"Contact" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"DATE" columnWidth:20 columnHeader:@"When" columnTextAlign:UITextAlignmentLeft] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"BOOLEANCHECK" columnWidth:20 columnHeader:@"Best Action" columnTextAlign:UITextAlignmentCenter] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSActionPossibleActionsDataPicker alloc] initWithList:[[bluesheetDataModel getActions] items] ID:ID] autorelease]];
	self.tableViewController = [[[PossibleActionsTableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"POSSIBLE ACTIONS" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/PossibleActions"] GetAttribute:@"url"];
    [colTypes release];
    [dataCon release];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repositoryDialogClosed:) name:@"repositoryDialogClosed" object:nil];
	return self;
}
-(void)repositoryDialogClosed:(NSNotification *)notification{
    WSKVPair *kvp = (WSKVPair *)[notification object];
    MHTableViewController *tvc = (MHTableViewController *)self.tableViewController;
    if(kvp.objectValue == tvc.repDialog){
        BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        WSAction *act = [[[WSAction alloc] initWithXML:nil ID:ID] autorelease];
        act.what = kvp.key;
        [dm updateObjectList:dm.actionsList updatedObject:act notificationType:@"Action"];
    }
}
@end
