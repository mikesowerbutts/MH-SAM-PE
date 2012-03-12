//
//  PossibleActionsTableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "PossibleActionsTableViewController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObject.h"
#import "WSDraggableButton.h"
#import "MHTableViewController.h"
#import "BlueSheetDataModel.h"
#import "MHFlagButtonController.h"
#import "WSAppletButtonLabel.h"
#import "MHTableLabel.h"
#import "PossibleActions_Dialog_Controller.h"

@implementation PossibleActionsTableViewController
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[PossibleActions_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"PossibleActions_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Possible Action"];
	[editDialog showPopoverInCenter];
}
-(void)additionalVarsSetup{
    self.repositoryXPath = @"Actions";
    self.repDialogHeading = @"Suggested Actions";
}
@end
