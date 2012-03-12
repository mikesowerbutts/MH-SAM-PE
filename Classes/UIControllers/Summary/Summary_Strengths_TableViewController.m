//
//  Summary_Strengths_TableViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "Summary_Strengths_TableViewController.h"
#import "Summary_Strengths_Dialog_Controller.h"

@implementation Summary_Strengths_TableViewController
-(void)showEditDialog:(NSString *)theID srcRect:(CGRect)theSrcRect{	
	editDialog = [[Summary_Strengths_Dialog_Controller alloc] initWithXIBAndIDDontShow:@"Summary_Strengths_Dialog" mainView:self.delegate.view ID:ID];
	[editDialog setupDialog:theID ID:ID];
	[editDialog.headerLabel setValue:@"Strength"];
	[editDialog showPopoverInCenter];
}
-(void)additionalVarsSetup{
    self.repositoryXPath = @"Strengths";
    self.repDialogHeading = @"Suggested Strengths";
}
@end
