//
//  TopButtons.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSButton.h"
#import "WSButtonController.h"
#import "WSPrintDialogController.h"
#import "MHManagersNotesDialogController.h"
#import "MHNotesDialogController.h"
#import "BlueSheetViewController.h"

@interface BSTopButtons : NSObject {
	WSButton *eLearningBtn;
	WSButton *managersNotesBtn;
	WSButton *notesBtn;
	WSButton *printBtn;
	WSButton *helpBtn;
	WSButton *saveBtn;
	WSButton *exitBtn;
	WSButtonController *eLearning_Controller;
	WSButtonController *managersNotes_Controller;
	WSButtonController *notes_Controller;
	WSButtonController *print_Controller;
	WSButtonController *help_Controller;
	WSButtonController *save_Controller;
	WSButtonController *exit_Controller;
	NSString *ID;
	WSPrintDialogController *printDialogController;
	MHManagersNotesDialogController *managersNotesDialogController;
	MHNotesDialogController *notesDialogController;
    BlueSheetViewController *Owner;
}
@property(nonatomic, assign)BlueSheetViewController *Owner;
@property(nonatomic, retain)MHManagersNotesDialogController *managersNotesDialogController;
@property(nonatomic, retain)MHNotesDialogController *notesDialogController;
@property(nonatomic, retain)WSPrintDialogController *printDialogController;
@property(nonatomic, retain)NSString *ID;
@property(nonatomic, retain)WSButton *eLearningBtn;
@property(nonatomic, retain)WSButton *managersNotesBtn;
@property(nonatomic, retain)WSButton *notesBtn;
@property(nonatomic, retain)WSButton *printBtn;
@property(nonatomic, retain)WSButton *helpBtn;
@property(nonatomic, retain)WSButton *saveBtn;
@property(nonatomic, retain)WSButton *exitBtn;
@property(nonatomic, retain)WSButtonController *eLearning_Controller;
@property(nonatomic, retain)WSButtonController *managersNotes_Controller;
@property(nonatomic, retain)WSButtonController *notes_Controller;
@property(nonatomic, retain)WSButtonController *print_Controller;
@property(nonatomic, retain)WSButtonController *help_Controller;
@property(nonatomic, retain)WSButtonController *save_Controller;
@property(nonatomic, retain)WSButtonController *exit_Controller;

-(id)initWithButtons:(WSButton *)theELearningBtn 
			managersNotesBtn:(WSButton *)theManagersNotesBtn
			notesBtn:(WSButton *)theNotesBtn 
			printBtn:(WSButton *)thePrintBtn 
			helpBtn:(WSButton *)theHelpBtn
			saveBtn:(WSButton *)theSaveBtn
			exitBtn:(WSButton *)theExitBtn
			ID:(NSString *)theID
            Owner:(BlueSheetViewController *)aOwner;
-(void)checkManagersNotes;
-(void)checkAdditionalNotes;
@end
