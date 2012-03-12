    //
//  Summary_RedFlags_Co.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 03/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "Summary_RedFlags_Controller.h"
#import "WSXMLObject.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"
#import "BSRedFlagDataPicker.h"
#import "WSTableViewDataController.h"
#import "Summary_RedFlags_Dialog_Controller.h"
#import "Summary_RedFlags_TableViewController.h"

@implementation Summary_RedFlags_Controller
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData ID:(NSString *)theID{
	[super doInit:theTable data:theData notificationType:@"RedFlag" ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	data = theData;
	NSMutableArray *colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
	[colTypes addObject:[[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:100 columnHeader:@"Red Flag" columnTextAlign:UITextAlignmentLeft] autorelease]];
	WSTableViewDataController *dataCon = [[WSTableViewDataController alloc] initWithPicker:[[[BSRedFlagDataPicker alloc] initWithList:[[bluesheetDataModel getRedFlags] items] ID:ID] autorelease]];
	self.tableViewController = [[[Summary_RedFlags_TableViewController alloc] initWithColsAndTable:dataCon readOnly:NO multiSelect:NO selectedRowsData:nil table:theTable columnTypes:colTypes tableTitle:@"" groupMode:@"NONE" showColHeaders:YES ID:ID] autorelease];
	tableViewController.mode = @"NORMAL";
	tableViewController.editMode = @"DIALOG";
	tableViewController.showAllRows = NO;
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
        BSRedFlag *bsRF = [[[BSRedFlag alloc] initWithXML:nil ID:ID] autorelease];
        bsRF.description = kvp.key;
        [dm updateObjectList:dm.redFlagsList updatedObject:bsRF notificationType:@"RedFlag"];
    }
}@end
