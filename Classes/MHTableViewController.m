    //
//  MHTableController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTableViewController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObject.h"
#import "WSDraggableButton.h"
#import "MHFlagButtonController.h"
#import "WSAppletButtonLabel.h"
#import "MHTableLabel.h"
#import "MHTableBooleanCheckLabel.h"

@implementation MHTableViewController
@synthesize flagOffset, flaggable, repositoryXPath, repBtn, repBtnController, repDialog, tblRepN, repDialogHeading;
-(void)setupVars{
	[super setupVars];
	self.canFullScreen = YES;
	self.flagOffset = 0;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disable) name:@"MHDisableTables" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enable) name:@"MHEnableTables" object:nil];
}
-(void)disable{
	self.tableView.scrollEnabled = NO;
}
-(void)enable{
	self.tableView.scrollEnabled = YES;
}
-(WSLabel *)setupLabel:(CGFloat)prevWid tableView:(UITableView *)theTableView colIdx:(int)colIdx rowIdx:(int)rowIdx colRect:(CGRect)colRect cell:(WSTableViewCell *)cell ci:(WSColumnInfo *)ci{
	CGFloat colWid =  0.0;
	if(colIdx < [colTypes count] - 1)
		colWid = (self.tableView.frame.size.width / 100) * ci.colWidth;
	else
		colWid = self.tableView.frame.size.width - prevWid;
	colRect = CGRectMake(prevWid, 0, colWid, [self heightForRows:theTableView]);
	MHTableLabel *cellLabel = nil;
	if ([[ci colType] isEqualToString:@"APPLETBUTTON"]) {
		cellLabel = [[WSAppletButtonLabel alloc] initWithFrame:colRect ID:ID];
		WSAppletButtonLabel *btnLbl = (WSAppletButtonLabel *)cellLabel;
		btnLbl.button_Controller.tag = cell.ID;
	}
    else if ([[ci colType] isEqualToString:@"BOOLEANCHECK"]){
        MHTableBooleanCheckLabel *chkLbl = [[MHTableBooleanCheckLabel alloc] initWithFrame:colRect];
        cellLabel = chkLbl;
        NSString *aID = (![cell.ID2 isEqualToString:@""] && cell.ID2 != nil) ? cell.ID2 : cell.ID;
		NSString *fID = [NSString stringWithFormat:@"%@.%i", aID, colIdx + (flagOffset - 1)];
        if(self.flaggable)
            [cellLabel checkFlag:fID DataModelID:[self.delegate ID]];
    }
	else{
		cellLabel = [[MHTableLabel alloc] initWithFrame:colRect];
		NSString *aID = (![cell.ID2 isEqualToString:@""] && cell.ID2 != nil) ? cell.ID2 : cell.ID;
		NSString *fID = [NSString stringWithFormat:@"%@.%i", aID, colIdx + (flagOffset - 1)];
        if(self.flaggable)
            [cellLabel checkFlag:fID DataModelID:[self.delegate ID]];
	}
	return cellLabel;
}
-(void)additionalCellSetup:(WSLabel *)label{
	MHTableLabel *lbl = (MHTableLabel *)label;
	if(lbl.flagController != nil){
		lbl.flagController.containerView = self.tableView.superview;
	}
}
-(void)buildAdditionalButtons{
    BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
    WSXMLObject *repN = [dm.applicationData Get:@"Repository"];
    if(repN != nil){
        if(repositoryXPath != nil && ![repositoryXPath isEqualToString:@""]){
            self.tblRepN = [repN Get:repositoryXPath];
            if(tblRepN != nil){
                self.repBtn = [[[WSButton alloc] initWithFrameAndImages:CGRectMake(headerContainerView.frame.size.width - 32, 2, 30, 30)] autorelease];
                [self.repBtn.label setValue:@"..."];
                self.repBtn.label.borders = @"";
                [headerContainerView addSubview: self.repBtn];
                self.repBtnController = [[[WSButtonController alloc] initWithButton:self.repBtn ID:ID] autorelease];
            }
        }
    }
}
-(void)btnTouchedUpInside:(NSNotification *)notification{
    [super btnTouchedUpInside:notification];
	WSButtonController *sbtn = (WSButtonController *)[notification object];
    if(sbtn == self.repBtnController){
        self.repDialog = [[MHRepositoryDialog alloc] initWithXIBAndIDDontShow:@"WSBlankViewDialog" mainView:self.view ID:ID xmlData:tblRepN];
        [self.repDialog.headerLabel setValue:self.repDialogHeading];
        [self.repDialog showPopoverFromRect:self.repBtn.frame];
    }
    
}
-(void)dealloc{
    [super dealloc];
    [repositoryXPath release];
    [repBtn release];
    [repBtnController release];
    [tblRepN release];
    [repDialogHeading release];
}
@end
