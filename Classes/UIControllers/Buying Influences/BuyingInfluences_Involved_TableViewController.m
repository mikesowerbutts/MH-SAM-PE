//
//  BuyingInfluences_Involved_TableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Involved_TableViewController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObject.h"
#import "WSDraggableButton.h"
#import "MHTableViewController.h"
#import "BlueSheetDataModel.h"
#import "MHFlagButtonController.h"
#import "WSAppletButtonLabel.h"
#import "MHTableLabel.h"
#import "BuyingInfluences_Dialog_Controller.h"

@implementation BuyingInfluences_Involved_TableViewController
-(WSLabel *)setupLabel:(CGFloat)prevWid tableView:(UITableView *)theTableView colIdx:(int)colIdx rowIdx:(int)rowIdx colRect:(CGRect)colRect cell:(WSTableViewCell *)cell ci:(WSColumnInfo *)ci{
	WSLabel *cellLabel = nil;
	if ([[ci colType] isEqualToString:@"APPLETBUTTON"]) {
		cellLabel = [[WSAppletButtonLabel alloc] initWithFrame:colRect ID:ID];
		WSAppletButtonLabel *btnLbl = (WSAppletButtonLabel *)cellLabel;
		btnLbl.button_Controller.tag = cell.ID;
	}
	else{
		cellLabel = [[MHTableLabel alloc] initWithFrame:colRect];
		NSString *fID = [NSString stringWithFormat:@"%@.%i", cell.ID, (colIdx - 1) + flagOffset];
		[cellLabel checkFlag:fID DataModelID:[self.delegate ID]];
	}
	return cellLabel;
}
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[BuyingInfluences_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"BuyingInfluences_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Buying Influence"];
	[editDialog showPopoverInCenter];
}
@end
