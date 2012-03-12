//
//  InformationNeeded_TableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "InformationNeeded_TableViewController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObject.h"
#import "WSDraggableButton.h"
#import "MHTableViewController.h"
#import "BlueSheetDataModel.h"
#import "MHFlagButtonController.h"
#import "WSAppletButtonLabel.h"
#import "MHTableLabel.h"
#import "InformationNeeded_Dialog_Controller.h"

@implementation InformationNeeded_TableViewController
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[InformationNeeded_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"Information_Needed_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Information Needed"];
	[editDialog showPopoverInCenter];
}
@end