//
//  TopButtons.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BSTopButtons.h"
#import "WSButtonController.h"
#import "WSUtils.h"
#import "BlueSheetDataModel.h"

@implementation BSTopButtons
@synthesize eLearningBtn, managersNotesBtn, notesBtn, printBtn, helpBtn, saveBtn, exitBtn, eLearning_Controller, managersNotes_Controller ,notes_Controller, print_Controller, help_Controller, save_Controller, exit_Controller, ID, printDialogController, managersNotesDialogController, notesDialogController, Owner;
-(id)initWithButtons:(WSButton *)theELearningBtn 
			managersNotesBtn:(WSButton *)theManagersNotesBtn
			notesBtn:(WSButton *)theNotesBtn 
			printBtn:(WSButton *)thePrintBtn 
			helpBtn:(WSButton *)theHelpBtn
			saveBtn:(WSButton *)theSaveBtn
			exitBtn:(WSButton *)theExitBtn
                  ID:(NSString *)theID Owner:(BlueSheetViewController *)aOwner{
	self.Owner = aOwner;
	self.ID = theID;
	self.eLearningBtn = theELearningBtn;
	self.managersNotesBtn = theManagersNotesBtn;
	self.notesBtn = theNotesBtn;
	self.printBtn = thePrintBtn;
	self.helpBtn = theHelpBtn;
	self.saveBtn = theSaveBtn;
	self.exitBtn = theExitBtn;
	
	self.eLearning_Controller = [[[WSButtonController alloc] initWithButton:eLearningBtn ID:ID] autorelease];//Leak
	eLearningBtn.imageView.image = [UIImage imageNamed:@"elearning.png"];
	eLearningBtn.highlight.hidden = YES;
	
	self.managersNotes_Controller = [[[WSButtonController alloc] initWithButton:managersNotesBtn ID:ID] autorelease];
	managersNotesBtn.imageView.image = [UIImage imageNamed:@"managersnotes.png"];
	managersNotesBtn.highlight.hidden = YES;
    
	
	self.notes_Controller = [[[WSButtonController alloc] initWithButton:notesBtn ID:ID] autorelease];//Leak
	notesBtn.imageView.image = [UIImage imageNamed:@"notes.png"];
	notesBtn.highlight.hidden = YES;

	self.print_Controller = [[[WSButtonController alloc] initWithButton:printBtn ID:ID] autorelease];//Leak
	printBtn.imageView.image = [UIImage imageNamed:@"print.png"];
	printBtn.highlight.hidden = YES;

	self.help_Controller = [[[WSButtonController alloc] initWithButton:helpBtn ID:ID] autorelease];//Leak
	helpBtn.imageView.image = [UIImage imageNamed:@"help.png"];
	helpBtn.highlight.hidden = YES;

	self.save_Controller = [[[WSButtonController alloc] initWithButton:saveBtn ID:ID] autorelease];//Leak
	saveBtn.imageView.image = [UIImage imageNamed:@"save.png"];
	saveBtn.highlight.hidden = YES;

	self.exit_Controller = [[[WSButtonController alloc] initWithButton:exitBtn ID:ID] autorelease];//Leak
	exitBtn.imageView.image = [UIImage imageNamed:@"exit.png"];
	exitBtn.highlight.hidden = YES;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTouchedUpInside:) name:@"btnTouchUpInside" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkManagersNotes) name:@"checkManagersNotes" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkAdditionalNotes) name:@"checkAdditionalNotes" object:nil];
    [self checkManagersNotes];
    [self checkAdditionalNotes];
	return self;
}
-(void)checkManagersNotes{
    BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
    NSArray *arr = [[dm.fileData Get:@"ManagersNotes"] GetChildAttributesByName:@"Notes"];
    BOOL exists = NO;
    for(int i = 0; i < [arr count]; i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            exists = YES;
            break;
        }
    }
    self.managersNotesBtn.alpha = exists == YES ? 1.0 : 0.5;
}
-(void)checkAdditionalNotes{
    BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
    WSXMLObject *oppNotesN = [dm.fileData Get:@"OpportunityNotes"];
    BOOL isBlank = YES;
    if(oppNotesN != nil && ![[oppNotesN innerXML] isEqualToString:@""])
        isBlank = NO;
    if(isBlank) self.notesBtn.alpha = 0.5;
    else self.notesBtn.alpha = 1.0;
}
-(void)btnTouchedUpInside:(NSNotification *)notification{
    WSButtonController *sbtn = (WSButtonController *)[notification object];
    if(sbtn == eLearning_Controller || sbtn == managersNotes_Controller || sbtn == notes_Controller || sbtn == print_Controller || sbtn == help_Controller || sbtn == save_Controller || sbtn == exit_Controller){
        BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        
        if(sbtn == eLearning_Controller){
            WSKVPair *kvp = [[WSKVPair alloc] initWithKeyValue:@"Miller Heiman E-Learning" aValue:[[bluesheetDataModel.applicationData Get:@"Options/URLS/ECoaching"] GetAttribute:@"url"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchURL" object:kvp];
            [kvp release];
        }
        else if(sbtn == managersNotes_Controller){
            self.managersNotesDialogController = [[[MHManagersNotesDialogController alloc] initWithXIBAndIDDontShow:@"ManagersNotes" mainView:self.notesBtn.superview ID:ID] autorelease];//Leak
            CGRect tRect = CGRectMake(1024/2, 768/2, 1, 1);
            [managersNotesDialogController showPopoverFromRect:tRect];
        }
        else if(sbtn == notes_Controller){
            self.notesDialogController = [[[MHNotesDialogController alloc] initWithXIBAndIDDontShow:@"Notes" mainView:self.notesBtn.superview ID:ID] autorelease];//Leak
            CGRect tRect = CGRectMake(1024/2, 768/2, 1, 1);
            [notesDialogController showPopoverFromRect:tRect];
        }
        else if(sbtn == print_Controller){
            self.printDialogController = [[WSPrintDialogController alloc] initWithXIBAndIDDontShow:@"BSPrintDialog" mainView:self.printBtn.superview ID:ID];
            [printDialogController setupDialog:@"" ID:ID];
            CGRect tRect = CGRectMake(1024/2, 768/2, 1, 1);
            [printDialogController showPopoverFromRect:tRect];
        }
        else if(sbtn == help_Controller){
            [Owner showWebBrowser:[NSString stringWithFormat:@"%@/MH_PE_iPad_Blue_Sheet_Help.pdf", [WSUtils GetResourcesPath]] title:@"Help" mode:@"PDF"];
        }
        else if(sbtn == save_Controller)
            [bluesheetDataModel saveData];
        else if(sbtn == exit_Controller)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"closeApplet" object:ID];
    }
}
-(void)dealloc{
    [eLearningBtn release];
    [managersNotesBtn release];
    [notesBtn release];
    [printBtn release];
    [helpBtn release];
    [saveBtn release];
    [exitBtn release];
    [eLearning_Controller release];
    [managersNotes_Controller release];
    [notes_Controller release];
    [print_Controller release];
    [help_Controller release];
    [save_Controller release];
    [exit_Controller release];
    [ID release];
    [printDialogController release];
    [managersNotesDialogController release];
    [notesDialogController release];
}
@end
