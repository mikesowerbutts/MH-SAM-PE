//
//  MHRepositoryDialog.m
//  MH SAM PE
//
//  Created by Toby Widdowson on 17/11/2011.
//  Copyright (c) 2011 White Springs Ltd. All rights reserved.
//

#import "MHRepositoryDialog.h"
#import "MHRepositoryDataPicker.h"
@implementation MHRepositoryDialog
@synthesize XMLData, tableViewController;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID xmlData:(WSXMLObject *)theXMLData{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
    self.XMLData = theXMLData;
    if(self.XMLData != nil){
        WSTableViewDataController *dataCon = [[[WSTableViewDataController alloc] initWithPicker:[[[MHRepositoryDataPicker alloc] initWithXML:XMLData ID:ID] autorelease]] autorelease];
        CGRect tblFrame = CGRectMake(0, 50, self.dialogView.frame.size.width, self.dialogView.frame.size.height - 50);
        NSMutableArray *colTypes = [[[NSMutableArray alloc] init] autorelease];
        [colTypes addObject:[[[WSColumnInfo alloc] initID] autorelease]];
        [colTypes addObject:[[[WSColumnInfo alloc] init:@"STRING" columnWidth:100 columnHeader:@"Description"] autorelease]];
        self.tableViewController = [[WSTableViewController alloc] initWithCols:dataCon readOnly:YES multiSelect:NO selectedRowsData:nil tableFrame:tblFrame columnTypes:colTypes tableTitle:@"Select an item from the list below" groupMode:@"NONE" showColHeaders:YES ID:ID searchable:NO];
        self.tableViewController.mode = @"NORMAL";
        self.tableViewController.editMode = @"NONE";
        self.tableViewController.delegate = self;
        self.tableViewController.tableView.delegate = self.tableViewController;
        [self.view addSubview:self.tableViewController.headerContainerView];
        [self.view addSubview:self.tableViewController.tableView];
        [self.view sendSubviewToBack:self.tableViewController.headerContainerView];
    }
    return self;
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
        if([self.tableViewController.selectedRowsData.items count] > 0){
            WSKVPair *selKVP = [self.tableViewController.selectedRowsData.items objectAtIndex:0];
            WSXMLObject *selN = [XMLData GetByAttributeValue:@"ID" attValue:selKVP.key];
            NSString *val = [WSUtils URLDecode:[selN GetAttribute:@"Description"]];
            NSLog(@"val: %@", val);
            WSKVPair *kvp = [[[WSKVPair alloc] initWithKeyObjectValue:val aObject:self] autorelease];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"repositoryDialogClosed" object:kvp];
        }
	}
	[super isClosing:mode];
	return YES;
}
@end
