//
//  BlueSheetViewController.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 04/05/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import "BlueSheetViewController.h"
#import "WSDateFieldController.h"
#import "WSXMLObject.h"
#import "ICP_Controller.h"
#import "WSTableViewGroupController.h"
#import "WSUtils.h"
#import "WSKVPairList.h"
#import "BSTopButtons.h"
#import "WSSectionController.h"
#import "WSStyle.h"

@implementation BlueSheetViewController
@synthesize dragDrop, acpSlider, acp_Controller;
@synthesize oppDets_Label, oppDets_Label_Controller, oppDets_CurrentVolume, oppDets_PotentialVolume, oppDets_CurrentVolume_Controller, oppDets_PotentialVolume_Controller, oppDets_Date, oppDets_SalesPerson, oppDets_Account, oppDets_Product, oppDets_CloseDate, oppDets_Date_Controller, oppDets_CloseDate_Controller, oppDets_Revenue, oppDets_Revenue_Controller, oppDets_SalesPerson_Controller, oppDets_Account_Controller, oppDets_Product_Controller;
@synthesize compSalesFunnel_Label, compSalesFunnel_Label_Controller, compSalesFunnel_CompType_Controller, compSalesFunnel_CompType, compSalesFunnel_specComps, compSalesFunnel_specComps_Controller, compSalesFunnel_myPosVsComp, compSalesFunnel_myPosVsComp_Controller, compSalesFunnel_plInSalesFun, compSalesFunnel_plInSalesFun_Controller, compSalesFunnel_timeForPri, compSalesFunnel_timeForPri_Controller;
@synthesize icpController, icp_ICCTable;
@synthesize buyInf_Involved, buyInf_Involved_Controller, buyInf_Results, buyInf_Results_Controller, buyInf_Covered, buyInf_Covered_Controller, buyInf_Group_Controller;
@synthesize summ_Strengths, summ_Strengths_Controller, summ_RedFlags, summ_RedFlags_Controller, possActions, possActions_Controller, bestActionPlan, bestActionPlan_Controller, informationNeeded, informationNeeded_Controller;
BestActionPlan_Controller *bestActionPlan_Controller;
InformationNeeded_Controller *informationNeeded_Controller;
- (void)viewDidLoad {
    @try{
        BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        bluesheetDataModel.vc = self;
        BSTopButtons *topBtns = [[BSTopButtons alloc] initWithButtons:eLearningBtn managersNotesBtn:managersNotesBtn notesBtn:notesBtn printBtn:printBtn helpBtn:helpBtn saveBtn:saveBtn exitBtn:exitBtn ID:ID Owner:self];	
        [super viewDidLoad];
        // Drag Drop
        [[self.dragDrop init] autorelease];
        if(bluesheetDataModel.manager.value)
            self.dragDrop.enabled = NO;
        
        // ACP
        self.acp_Controller = [[[BSAdequacyOfCPController alloc] initWithSliderAndSliderLoc:acpSlider sliderLoc:bluesheetDataModel.ACP] autorelease];
        if(bluesheetDataModel.manager.value)
            self.acp_Controller.enabled = NO;
        [self.acp_Controller checkFlag:@"2.2"];
        // Opportunity Details
        [self.oppDets_Label initNormal];
        self.oppDets_Label.highlight.hidden = YES;
        [self.oppDets_Label.label setValue:@"OPPORTUNITY DETAILS"];
        self.oppDets_Label.hidden = NO;
        self.oppDets_Label.label.font = [[WSStyle instance] getSecHeaderFont];
        self.oppDets_Label.label.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderFontHex]];
        self.oppDets_Label.label.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderBGHex]];
        self.oppDets_Label_Controller = [[WSButtonController alloc] initWithButton:self.oppDets_Label ID:ID];
        
        self.oppDets_Date = [[[MHTextField alloc] initWithFrame:CGRectMake(42, 109, 100, 25)] autorelease];
        self.oppDets_Date.font = [[WSStyle instance] getNormalFont];
        self.oppDets_Date.delegate = self;
        [self.view addSubview:self.oppDets_Date];
        self.oppDets_Date_Controller = [[[WSDateFieldController alloc] initWithFieldAndWSDate:oppDets_Date currentDate:bluesheetDataModel.date] autorelease];
        [oppDets_Date checkFlag:@"1.1"];
        
        self.oppDets_SalesPerson = [[[MHTextField alloc] initWithFrame:CGRectMake(226, 109, 115, 25)] autorelease];
        self.oppDets_SalesPerson.font = [[WSStyle instance] getNormalFont];
        self.oppDets_SalesPerson.delegate = self;
        [self.view addSubview:self.oppDets_SalesPerson];
        self.oppDets_SalesPerson_Controller = [[[WSTextFieldController alloc] initWithFieldAndValue:oppDets_SalesPerson value:[WSUtils StringFromNode:[[[WSDataModelManager instance] getByID:ID].fileData Get:@"SalesPerson"]]] autorelease];
        WSXMLObject *lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/SalesPerson"];
        if((lockN != nil && [[lockN innerXML] isEqualToString:@"true"]) || bluesheetDataModel.manager.value)
            self.oppDets_SalesPerson_Controller.editable = NO;
        [oppDets_SalesPerson checkFlag:@"1.2"];
            
        self.oppDets_Account = [[[MHTextField alloc] initWithFrame:CGRectMake(61, 135, 280, 25)] autorelease];
        self.oppDets_Account.font = [[WSStyle instance] getNormalFont];
        self.oppDets_Account.delegate = self;
        [self.view addSubview:self.oppDets_Account];
        self.oppDets_Account_Controller = [[[WSTextFieldController alloc] initWithFieldAndValue:oppDets_Account value:[WSUtils StringFromNode:[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Account"]]] autorelease];
        self.oppDets_Account_Controller.editable = NO;
        [oppDets_Account checkFlag:@"1.3"];
        
        self.oppDets_CurrentVolume = [[[MHTextField alloc] initWithFrame:CGRectMake(101, 161, 240, 25)] autorelease];
        self.oppDets_CurrentVolume.font = [[WSStyle instance] getNormalFont];
        self.oppDets_CurrentVolume.delegate = self;
        [self.view addSubview:self.oppDets_CurrentVolume];
        self.oppDets_CurrentVolume_Controller = [[[WSCurrencyFieldController alloc] initWithFieldAndCurrencyValue:oppDets_CurrentVolume value:[bluesheetDataModel.currentVolume copy]] autorelease];
        //lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/SalesUnits"];
        //if((lockN != nil && [[lockN innerXML] isEqualToString:@"true"]) || bluesheetDataModel.manager.value)
            //self.oppDets_CurrentVolume_Controller.editable = NO;
        
        self.oppDets_PotentialVolume = [[[MHTextField alloc] initWithFrame:CGRectMake(109, 187, 232, 25)] autorelease];
        self.oppDets_PotentialVolume.font = [[WSStyle instance] getNormalFont];
        self.oppDets_PotentialVolume.delegate = self;
        [self.view addSubview:self.oppDets_PotentialVolume];
        self.oppDets_PotentialVolume_Controller = [[[WSCurrencyFieldController alloc] initWithFieldAndCurrencyValue:oppDets_PotentialVolume value:[bluesheetDataModel.potentialVolume copy]] autorelease];	
        //lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/SalesUnits"];
        //if((lockN != nil && [[lockN innerXML] isEqualToString:@"true"]) || bluesheetDataModel.manager.value)
            //self.oppDets_PotentialVolume_Controller.editable = NO;
        
        self.oppDets_Product = [[[MHTextField alloc] initWithFrame:CGRectMake(61, 230, 280, 25)] autorelease];
        self.oppDets_Product.font = [[WSStyle instance] getNormalFont];
        self.oppDets_Product.delegate = self;
        [self.view addSubview:self.oppDets_Product];
        self.oppDets_Product_Controller = [[[WSTextFieldController alloc] initWithFieldAndValue:oppDets_Product value:bluesheetDataModel.product] autorelease];
        lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/Product"];
        NSLog(@"lockN: %@", [lockN innerXML]);
        if((lockN != nil && [[lockN innerXML] isEqualToString:@"true"]) || bluesheetDataModel.manager.value)
            self.oppDets_Product_Controller.editable = NO;
        [oppDets_Product checkFlag:@"1.6"];
	
        self.oppDets_Revenue = [[[MHTextField alloc] initWithFrame:CGRectMake(67, 256, 274, 25)] autorelease];
        self.oppDets_Revenue.font = [[WSStyle instance] getNormalFont];
        self.oppDets_Revenue.delegate = self;
        [self.view addSubview:self.oppDets_Revenue];
        self.oppDets_Revenue_Controller = [[[WSCurrencyFieldController alloc] initWithFieldAndCurrencyValue:oppDets_Revenue value:[bluesheetDataModel.revenue copy]] autorelease];
        lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/SalesUnits"];
        if(lockN != nil){
          if([[lockN innerXML] isEqualToString:@"true"] || bluesheetDataModel.manager.value)
            self.oppDets_Revenue_Controller.editable = NO;
        }
        [oppDets_Revenue checkFlag:@"1.7"];
        
        self.oppDets_CloseDate = [[[MHTextField alloc] initWithFrame:CGRectMake(78, 282, 263, 25)] autorelease];
        self.oppDets_CloseDate.font = [[WSStyle instance] getNormalFont];
        self.oppDets_CloseDate.delegate = self;
        [self.view addSubview:self.oppDets_CloseDate];
        self.oppDets_CloseDate_Controller = [[[WSDateFieldController alloc] initWithFieldAndWSDate:oppDets_CloseDate currentDate:bluesheetDataModel.closeDate] autorelease];
        lockN = [bluesheetDataModel.applicationData Get:@"Options/LockFields/CloseDate"];
        if(lockN != nil){
            if([[lockN innerXML] isEqualToString:@"true"] || bluesheetDataModel.manager.value)
                self.oppDets_CloseDate_Controller.editable = NO;
        }
        [oppDets_CloseDate checkFlag:@"1.8"];
            
        //Competition / Sales Funnel
        [self.compSalesFunnel_Label initNormal];
        self.compSalesFunnel_Label.highlight.hidden = YES;
        self.compSalesFunnel_Label.hidden = NO;
        self.compSalesFunnel_Label.label.font = [[WSStyle instance] getSecHeaderFont];
        self.compSalesFunnel_Label.label.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderFontHex]];
        self.compSalesFunnel_Label.label.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderBGHex]];
        [self.compSalesFunnel_Label.label setValue:@"COMPETITION / SALES FUNNEL"];
        self.compSalesFunnel_Label_Controller = [[WSButtonController alloc] initWithButton:self.compSalesFunnel_Label ID:ID];
            
        self.compSalesFunnel_CompType = [[[MHTextField alloc] initWithFrame:CGRectMake(454, 110, 222, 25)] autorelease];
        self.compSalesFunnel_CompType.font = [[WSStyle instance] getNormalFont];
        self.compSalesFunnel_CompType.delegate = self;
        [self.view addSubview:self.compSalesFunnel_CompType];
        self.compSalesFunnel_CompType_Controller = [[[WSListPickerController alloc] 
                                               initWithFieldListDataAndValue:compSalesFunnel_CompType 
                                               listData:[bluesheetDataModel getCompetitionType] 
                                               value:bluesheetDataModel.compType
                                               multiSelect:NO] autorelease];
        [compSalesFunnel_CompType checkFlag:@"2.6"];
        if(bluesheetDataModel.manager.value)
            compSalesFunnel_CompType_Controller.editable = NO;
            
        self.compSalesFunnel_specComps = [[[MHTextView alloc] initWithFrame:CGRectMake(349, 155, 326, 71)] autorelease];
        self.compSalesFunnel_specComps.textView.font = [[WSStyle instance] getNormalFont];
        self.compSalesFunnel_specComps.delegate = self;
        [self.view addSubview:self.compSalesFunnel_specComps];
        self.compSalesFunnel_specComps_Controller = [[[WSTextViewController alloc] 
                                                initWithFieldAndValue:compSalesFunnel_specComps 
                                                value:bluesheetDataModel.competitors] autorelease];
            self.compSalesFunnel_specComps_Controller.ID = self.ID;
        [compSalesFunnel_specComps checkFlag:@"2.1"];
        if(bluesheetDataModel.manager.value)
            compSalesFunnel_specComps_Controller.editable = NO;
        
        self.compSalesFunnel_myPosVsComp = [[[MHTextField alloc] initWithFrame:CGRectMake(505, 228, 171, 25)] autorelease];
        self.compSalesFunnel_myPosVsComp.font = [[WSStyle instance] getNormalFont];
        self.compSalesFunnel_myPosVsComp.delegate = self;
        [self.view addSubview:self.compSalesFunnel_myPosVsComp];
        self.compSalesFunnel_myPosVsComp_Controller = [[[WSListPickerController alloc] 
                                                  initWithFieldListDataAndValue:compSalesFunnel_myPosVsComp 
                                                  listData:[bluesheetDataModel getPosition] 
                                                  value:bluesheetDataModel.myPosition
                                                  multiSelect:NO] autorelease];
        [compSalesFunnel_myPosVsComp checkFlag:@"2.3"];
        if(bluesheetDataModel.manager.value)
            compSalesFunnel_myPosVsComp_Controller.editable = NO;
            
        compSalesFunnel_plInSalesFun = [[MHTextField alloc] initWithFrame:CGRectMake(476, 255, 200, 25)];
        self.compSalesFunnel_plInSalesFun.font = [[WSStyle instance] getNormalFont];
        self.compSalesFunnel_plInSalesFun.delegate = self;
        [self.view addSubview:self.compSalesFunnel_plInSalesFun];
        self.compSalesFunnel_plInSalesFun_Controller = [[[WSListPickerController alloc] 
                                                   initWithFieldListDataAndValue:compSalesFunnel_plInSalesFun 
                                                   listData:[bluesheetDataModel getFunnel]
                                                   value:bluesheetDataModel.placeInSalesFunnel
                                                   multiSelect:NO] autorelease];
        [compSalesFunnel_plInSalesFun checkFlag:@"2.4"];
        if(bluesheetDataModel.manager.value)
            compSalesFunnel_plInSalesFun_Controller.editable = NO;
        
        self.compSalesFunnel_timeForPri = [[[MHTextField alloc] initWithFrame:CGRectMake(476, 282, 200, 25)] autorelease];
        self.compSalesFunnel_timeForPri.font = [[WSStyle instance] getNormalFont];
        self.compSalesFunnel_timeForPri.delegate = self;
        [self.view addSubview:self.compSalesFunnel_timeForPri];
        self.compSalesFunnel_timeForPri_Controller = [[[WSListPickerController alloc] 
                                                 initWithFieldListDataAndValue:compSalesFunnel_timeForPri 
                                                 listData:[bluesheetDataModel getTimings] 
                                                 value:bluesheetDataModel.timingForPriorities
                                                 multiSelect:NO] autorelease];
        [compSalesFunnel_timeForPri checkFlag:@"2.5"];
        if(bluesheetDataModel.manager.value)
            compSalesFunnel_timeForPri_Controller.editable = NO;
        //ICP
        self.icpController = [[[ICP_Controller alloc] doInit:icp_ICCTable ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            icpController.enabled = NO;
        NSMutableArray *buyInf_Controllers = [[NSMutableArray alloc] init];
        self.buyInf_Involved_Controller = [[[BuyingInfluences_Involved_Controller alloc] doInit:buyInf_Involved data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Influences"] retain] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.buyInf_Involved_Controller.enabled = NO;
        self.buyInf_Results_Controller = [[[BuyingInfluences_Results_Controller alloc] doInit:buyInf_Results data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Influences"] retain] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.buyInf_Results_Controller.enabled = NO;
        self.buyInf_Covered_Controller = [[[BuyingInfluences_Covered_Controller alloc] doInit:buyInf_Covered data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Influences"] retain] ID:ID] autorelease];
        [buyInf_Controllers addObject:[buyInf_Involved_Controller.tableViewController autorelease]];
        [buyInf_Controllers addObject:[buyInf_Results_Controller.tableViewController autorelease]];
        [buyInf_Controllers addObject:[buyInf_Covered_Controller.tableViewController autorelease]];
        self.buyInf_Group_Controller = [[[WSTableViewGroupController alloc] initWithTableViews:buyInf_Controllers] autorelease];
        self.summ_Strengths_Controller = [[[Summary_Strengths_Controller alloc] doInit:summ_Strengths data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Strengths"] retain] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.summ_Strengths_Controller.enabled = NO;
        self.summ_RedFlags_Controller = [[[Summary_RedFlags_Controller alloc] doInit:summ_RedFlags data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"RedFlags"] retain] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.summ_RedFlags_Controller.enabled = NO;
        self.possActions_Controller = [[[PossibleActions_Controller alloc] doInit:possActions data:[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Actions"] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.possActions_Controller.enabled = NO;
        self.bestActionPlan_Controller = [[[BestActionPlan_Controller alloc] doInit:bestActionPlan data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"Actions"] retain] ID:ID] autorelease];
        self.informationNeeded_Controller = [[[InformationNeeded_Controller alloc] doInit:informationNeeded data:[[[[WSDataModelManager instance] getByID:ID].fileData Get:@"BestInfos"] retain] ID:ID] autorelease];
        if(bluesheetDataModel.manager.value)
            self.informationNeeded_Controller.enabled = NO;
        bluesheetDataModel.lastSave = [bluesheetDataModel createSaveXML];
    }
    @catch (NSException *ex) {
        NSLog(@"Error in BlueSheetViewController: %@", ex.reason);
    }
}
- (id)initWithNibNameAndXML:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil XML:(WSXMLObject *)theXML AppletID:(NSString *)AppletID {
	if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.ID = AppletID;
		WSXMLObject *xmlObj = [[WSXMLObject alloc] init:[theXML outerXML]];
		[[BlueSheetDataModel alloc] initWithXML:xmlObj ID:self.ID];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTouchedUpInside:) name:@"btnTouchUpInside" object:nil];
	}
	self.modalInPopover = YES;
	return self;
}
-(void)btnTouchedUpInside:(NSNotification *)notification{
    WSButtonController *sbtn = (WSButtonController *)[notification object];
    if(sbtn == self.oppDets_Label_Controller){
        BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        NSString *url = [[bluesheetDataModel.applicationData Get:@"Options/URLS/OpportunityDetails"] GetAttribute:@"url"];
        WSKVPair *kvp = [[WSKVPair alloc] initWithKeyValue:@"Miller Heiman E-Learning" aValue:url];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchURL" object:kvp];
        [kvp release];
    }
    else if(sbtn == self.compSalesFunnel_Label_Controller){
        BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
        NSString *url = [[bluesheetDataModel.applicationData Get:@"Options/URLS/Competition"] GetAttribute:@"url"];
        WSKVPair *kvp = [[WSKVPair alloc] initWithKeyValue:@"Miller Heiman E-Learning" aValue:url];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchURL" object:kvp];
        [kvp release];
    }
}
- (void)dealloc {
    //Other
    [dragDrop release];
    [acp_Controller release];
    [acpSlider release];
    //Fields
    [oppDets_Date release];
    [oppDets_Date removeFromSuperview];
    [oppDets_Date_Controller release];
    
    [oppDets_CloseDate release];
    [oppDets_CloseDate removeFromSuperview];
	[oppDets_CloseDate_Controller release];

    [oppDets_CurrentVolume release];
    [oppDets_CurrentVolume removeFromSuperview];
    [oppDets_CurrentVolume_Controller release];
    
    [oppDets_PotentialVolume release];
    [oppDets_PotentialVolume removeFromSuperview];
	[oppDets_PotentialVolume_Controller release];
    
    [oppDets_SalesPerson release];
    [oppDets_SalesPerson removeFromSuperview];
    [oppDets_SalesPerson_Controller release];
    
    [oppDets_Account release];
    [oppDets_Account removeFromSuperview];
    [oppDets_Account_Controller release];
    
    [oppDets_Product release];
    [oppDets_Product removeFromSuperview];
    [oppDets_Product_Controller release];
    
    [oppDets_Revenue release];
    [oppDets_Revenue removeFromSuperview];
	[oppDets_Revenue_Controller release];
    
    [compSalesFunnel_plInSalesFun release];
    [compSalesFunnel_plInSalesFun removeFromSuperview];
    [compSalesFunnel_plInSalesFun_Controller release];

    [compSalesFunnel_CompType release];
    [compSalesFunnel_CompType removeFromSuperview];
    [compSalesFunnel_CompType_Controller release];
    
    [compSalesFunnel_specComps release];
    [compSalesFunnel_specComps removeFromSuperview];
	[compSalesFunnel_specComps_Controller release];
    
    [compSalesFunnel_myPosVsComp release];
    [compSalesFunnel_myPosVsComp removeFromSuperview];
	[compSalesFunnel_myPosVsComp_Controller release];
    
    [compSalesFunnel_timeForPri release];
    [compSalesFunnel_timeForPri removeFromSuperview];
	[compSalesFunnel_timeForPri_Controller release];
     
    //Tables
    [icp_ICCTable release];
	[icpController release];
    
	[buyInf_Involved release];
	[buyInf_Results release];
	[buyInf_Covered release];
    
	[summ_Strengths release];
	[summ_Strengths_Controller release];
    
	[summ_RedFlags release];
	[summ_RedFlags_Controller release];
    
	[possActions release];
	[possActions_Controller release];
    
	[bestActionPlan release];
	[bestActionPlan_Controller release];
    
	[informationNeeded release];
	[informationNeeded_Controller release];
    [super dealloc];
}
@end
