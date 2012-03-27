    //
//  Summary_Strengths_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 03/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "Summary_Strengths_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"
#import "BSStrengthDataPicker.h"
#import "WSTableViewDataController.h"
#import "Summary_Strengths_Dialog_Controller.h"
#import "Summary_Strengths_TableViewController.h"

@implementation Summary_Strengths_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"Strength" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	self.data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:100 columnHeader:@"Strength" columnTextAlign:UITextAlignmentLeft] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSStrengthDataPicker alloc] initWithList:[[bluesheetDataModel getStrengths] items] ID:ID] autorelease]];
	self.tableViewController = [[[Summary_Strengths_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"SUMMARY OF MY POSITION TODAY" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
    tableViewController.headerURL = [[bluesheetDataModel.applicationData Get:@"Options/URLS/SummaryOfPosition"] GetAttribute:@"url"];
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
        BSStrength *bsStr = [[[BSStrength alloc] initWithXML:nil ID:ID] autorelease];
        bsStr.description = kvp.key;
        [dm updateObjectList:dm.strengthsList updatedObject:bsStr notificationType:@"Strength"];
    }
}
@end
