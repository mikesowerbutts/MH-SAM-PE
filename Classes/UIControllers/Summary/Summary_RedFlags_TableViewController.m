//
//  Summary_RedFlags_TableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "Summary_RedFlags_TableViewController.h"
#import "Summary_RedFlags_Dialog_Controller.h"

@implementation Summary_RedFlags_TableViewController
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[Summary_RedFlags_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"Summary_RedFlags_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Red Flag"];
	[editDialog showPopoverInCenter];
}
-(void)additionalVarsSetup{
    self.repositoryXPath = @"RedFlags";
    self.repDialogHeading = @"Suggested Red Flags";
}
@end
