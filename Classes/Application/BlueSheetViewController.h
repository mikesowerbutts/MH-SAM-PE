//
//  BlueSheetViewController.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 04/05/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BlueSheetDataModel.h"

#import "WSAppViewController.h"

#import "WSDateFieldController.h"

#import "WSListPickerController.h"

#import "MHTextView.h"
#import "WSTextViewController.h"

#import "MHTextField.h"
#import "WSTextFieldController.h"

#import "WSNumberFieldController.h"

#import "WSCurrencyFieldController.h"

#import "MHTableViewController.h"
#import "WSTableViewGroupController.h"
#import "ICP_Controller.h"
#import "BuyingInfluences_Covered_Controller.h"
#import "BuyingInfluences_Involved_Controller.h"
#import "BuyingInfluences_Results_Controller.h"
#import "Summary_RedFlags_Controller.h"
#import "Summary_Strengths_Controller.h"
#import "BestActionPlan_Controller.h"
#import "InformationNeeded_Controller.h"
#import "PossibleActions_Controller.h"
#import "WSSlider.h"
#import "BSAdequacyOfCPController.h"
#import "BSDragDrop.h"
#import "MHAppletViewController.h"


@interface BlueSheetViewController : MHAppletViewController {
	//Top Buttons
	IBOutlet WSButton *eLearningBtn;
	IBOutlet WSButton *managersNotesBtn;
	IBOutlet WSButton *notesBtn;
	IBOutlet WSButton *printBtn;
	IBOutlet WSButton *helpBtn;
	
	//Drag and Drop
	IBOutlet BSDragDrop *dragDrop;
	
	//Adequacy of Current Position
	IBOutlet WSSlider *acpSlider;
	BSAdequacyOfCPController *acp_Controller;
	
	//OPPORTUNITIY DETAILS
	IBOutlet WSButton *oppDets_Label;
    WSButtonController *oppDets_Label_Controller;
	MHTextField *oppDets_Date;
	MHTextField *oppDets_SalesPerson;
	MHTextField *oppDets_Account;
	MHTextField *oppDets_CurrentVolume;
	MHTextField *oppDets_PotentialVolume;
	MHTextField *oppDets_Product;
	MHTextField *oppDets_Revenue;
	MHTextField *oppDets_CloseDate;
	
	WSDateFieldController *oppDets_Date_Controller;
	WSTextFieldController *oppDets_SalesPerson_Controller;
	WSTextFieldController *oppDets_Account_Controller;
	WSCurrencyFieldController *oppDets_CurrentVolume_Controller;
	WSCurrencyFieldController *oppDets_PotentialVolume_Controller;
	WSTextFieldController *oppDets_Product_Controller;
	WSCurrencyFieldController *oppDets_Revenue_Controller;
	WSDateFieldController *oppDets_CloseDate_Controller;
	
	//COMPETITION / SALES FUNNEL
	IBOutlet WSButton *compSalesFunnel_Label;
    WSButtonController *compSalesFunnel_Label_Controller;
	MHTextField *compSalesFunnel_CompType;
	MHTextField *compSalesFunnel_myPosVsComp;
	MHTextField *compSalesFunnel_plInSalesFun;
	MHTextField *compSalesFunnel_timeForPri;
	MHTextView *compSalesFunnel_specComps;
	WSListPickerController *compSalesFunnel_CompType_Controller;
	WSListPickerController *compSalesFunnel_myPosVsComp_Controller;
	WSListPickerController *compSalesFunnel_plInSalesFun_Controller;
	WSListPickerController *compSalesFunnel_timeForPri_Controller;
	WSTextViewController *compSalesFunnel_specComps_Controller;
	
	//ICP
	IBOutlet WSTableView *icp_ICCTable;
	ICP_Controller *icpController;
	
	//BUYING INFLUENCES
	IBOutlet WSTableView *buyInf_Involved;
	IBOutlet WSTableView *buyInf_Results;
	IBOutlet WSTableView *buyInf_Covered;
	WSTableViewGroupController *buyInf_Group_Controller;
	BuyingInfluences_Involved_Controller *buyInf_Involved_Controller;
	BuyingInfluences_Results_Controller *buyInf_Results_Controller;
	BuyingInfluences_Covered_Controller *buyInf_Covered_Controller;
	
	//SUMMARY
	IBOutlet WSTableView *summ_Strengths;
	IBOutlet WSTableView *summ_RedFlags;
	Summary_Strengths_Controller *summ_Strengths_Controller;
	Summary_RedFlags_Controller *summ_RedFlags_Controller;
	
	//POSSIBLE ACTIONS
	IBOutlet WSTableView *possActions;
	PossibleActions_Controller *possActions_Controller;
	
	//BEST ACTION PLAN
	IBOutlet WSTableView *bestActionPlan;
	IBOutlet WSTableView *informationNeeded;
	BestActionPlan_Controller *bestActionPlan_Controller;
	InformationNeeded_Controller *informationNeeded_Controller;
}
//Drag and Drop
@property(nonatomic, retain)IBOutlet BSDragDrop *dragDrop;

// Adequacy of Current Position
@property(nonatomic, retain)IBOutlet WSSlider *acpSlider;
@property(nonatomic, retain)BSAdequacyOfCPController *acp_Controller;

//OPPORTUNITIY DETAILS
@property(nonatomic, retain)IBOutlet WSButton *oppDets_Label;
@property(nonatomic, retain)WSButtonController *oppDets_Label_Controller;
@property(nonatomic, retain)MHTextField *oppDets_Date;
@property(nonatomic, retain)MHTextField *oppDets_SalesPerson;
@property(nonatomic, retain)MHTextField *oppDets_Account;
@property(nonatomic, retain)MHTextField *oppDets_CurrentVolume;
@property(nonatomic, retain)MHTextField *oppDets_PotentialVolume;
@property(nonatomic, retain)MHTextField *oppDets_Product;
@property(nonatomic, retain)MHTextField *oppDets_Revenue;
@property(nonatomic, retain)MHTextField *oppDets_CloseDate;

@property(nonatomic, retain)WSDateFieldController *oppDets_Date_Controller;
@property(nonatomic, retain)WSTextFieldController *oppDets_SalesPerson_Controller;
@property(nonatomic, retain)WSTextFieldController *oppDets_Account_Controller;
@property(nonatomic, retain)WSCurrencyFieldController *oppDets_CurrentVolume_Controller;
@property(nonatomic, retain)WSCurrencyFieldController *oppDets_PotentialVolume_Controller;
@property(nonatomic, retain)WSTextFieldController *oppDets_Product_Controller;
@property(nonatomic, retain)WSCurrencyFieldController *oppDets_Revenue_Controller;
@property(nonatomic, retain)WSDateFieldController *oppDets_CloseDate_Controller;


//COMPETITION / SALES FUNNEL
@property(nonatomic, retain)IBOutlet WSButton *compSalesFunnel_Label;
@property(nonatomic, retain)WSButtonController *compSalesFunnel_Label_Controller;
@property(nonatomic, retain)MHTextField *compSalesFunnel_CompType;
@property(nonatomic, retain)MHTextView *compSalesFunnel_specComps;
@property(nonatomic, retain)MHTextField *compSalesFunnel_myPosVsComp;
@property(nonatomic, retain)MHTextField *compSalesFunnel_plInSalesFun;
@property(nonatomic, retain)MHTextField *compSalesFunnel_timeForPri;

@property(nonatomic, retain)WSListPickerController *compSalesFunnel_CompType_Controller;
@property(nonatomic, retain)WSTextViewController *compSalesFunnel_specComps_Controller;
@property(nonatomic, retain)WSListPickerController *compSalesFunnel_myPosVsComp_Controller;
@property(nonatomic, retain)WSListPickerController *compSalesFunnel_plInSalesFun_Controller;
@property(nonatomic, retain)WSListPickerController *compSalesFunnel_timeForPri_Controller;


//ICP
@property(nonatomic, retain)IBOutlet WSTableView *icp_ICCTable;
@property(nonatomic, retain)ICP_Controller *icpController;

//Buying Influences
@property(nonatomic, retain)WSTableViewGroupController *buyInf_Group_Controller;
@property(nonatomic, retain)BuyingInfluences_Results_Controller *buyInf_Results_Controller;
@property(nonatomic, retain)BuyingInfluences_Involved_Controller *buyInf_Involved_Controller;
@property(nonatomic, retain)BuyingInfluences_Covered_Controller *buyInf_Covered_Controller;

@property(nonatomic, retain)IBOutlet WSTableView *buyInf_Involved;
@property(nonatomic, retain)IBOutlet WSTableView *buyInf_Results;
@property(nonatomic, retain)IBOutlet WSTableView *buyInf_Covered;

//SUMMARY
@property(nonatomic, retain)IBOutlet WSTableView *summ_Strengths;
@property(nonatomic, retain)IBOutlet WSTableView *summ_RedFlags;
@property(nonatomic, retain)Summary_Strengths_Controller *summ_Strengths_Controller;
@property(nonatomic, retain)Summary_RedFlags_Controller *summ_RedFlags_Controller;

//POSSIBLE ACTIONS
@property(nonatomic, retain)IBOutlet WSTableView *possActions;
@property(nonatomic, retain)PossibleActions_Controller *possActions_Controller;

//BEST ACTION PLAN
@property(nonatomic, retain)IBOutlet WSTableView *bestActionPlan;
@property(nonatomic, retain)IBOutlet WSTableView *informationNeeded;
@property(nonatomic, retain)BestActionPlan_Controller *bestActionPlan_Controller;
@property(nonatomic, retain)InformationNeeded_Controller *informationNeeded_Controller;

- (id)initWithNibNameAndXML:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil XML:(WSXMLObject *)theXML;
-(NSString *)GetTypeByOrder:(NSString *)order node:(WSXMLObject *)theNode;
-(void)BuildCustomHeader;
@end

