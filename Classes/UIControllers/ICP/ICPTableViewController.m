//
//  ICPTableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "ICPTableViewController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObject.h"
#import "WSDraggableButton.h"
#import "MHTableViewController.h"
#import "BlueSheetDataModel.h"
#import "MHFlagButtonController.h"
#import "WSAppletButtonLabel.h"
#import "MHTableLabel.h"
#import "ICP_Dialog_Controller.h"
@implementation ICPTableViewController
-(WSLabel *)setupLabel:(CGFloat)prevWid tableView:(UITableView *)theTableView colIdx:(int)colIdx rowIdx:(int)rowIdx colRect:(CGRect)colRect cell:(WSTableViewCell *)cell ci:(WSColumnInfo *)ci{
	WSLabel *cellLabel = nil;
	if ([[ci colType] isEqualToString:@"APPLETBUTTON"]) {
		cellLabel = [[WSAppletButtonLabel alloc] initWithFrame:colRect ID:ID];
		WSAppletButtonLabel *btnLbl = (WSAppletButtonLabel *)cellLabel;
		btnLbl.button_Controller.tag = cell.ID;
	}
	else{
		cellLabel = [[MHTableLabel alloc] initWithFrame:colRect];
		NSString *fID = [NSString stringWithFormat:@"ICC.%i.%i", rowIdx, (colIdx - 1) + flagOffset];
		[cellLabel checkFlag:fID DataModelID:[self.delegate ID]];
	}
	return cellLabel;
}
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[ICP_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"ICP_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Ideal Customer Criteria"];
	[editDialog showPopoverInCenter];
}
@end
