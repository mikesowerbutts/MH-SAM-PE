//
//  MH_SAM_PEViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PEViewController.h"
#import "MH_SAM_PE_DataModel.h"
#import "MH_SAM_PE_CRM_Opportunity.h"
#import "BlueSheetViewController.h"
#import "WSUtils.h"
#import "WSDraggableTabBarButtonController.h"
#import "WSURLConnectionManager.h"
#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "WSPE_ConnectionStrings.h"

@implementation MH_SAM_PEViewController
@synthesize currentDM, progressDialog, activeOpportunity, connManager;
- (void)viewDidLoad {
    self.connManager = [[[WSURLConnectionManager alloc] init] autorelease];
	self.dm = [[MH_SAM_PE_DataModel alloc] init:@"WSPE" ID:@"PE"];
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkLaunchOpportunity:) name:@"launchOpportunity" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeApplet:) name:@"closeApplet" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveOpportunityBlobXML:) name:@"saveOpportunityBlobXML" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createPrint:) name:@"createPrint" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoaded:) name:@"connectionFinishedLoading" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionFailed:) name:@"connectionFailed" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchURL:) name:@"LaunchURL" object:nil];
}
-(void)launchURL:(NSNotification *)notification{
	[self showWebBrowser:[[notification object] value] title:[[notification object] key] mode:@"WEB"];
}
-(void)createPrint:(NSNotification *)notification{
	self.progressDialog = [WSProgressBarDialogController instance];
	[self.progressDialog.label setValue:@"Creating PDF..."];
	self.progressDialog.activityIndicator.hidden = NO;
	[self.progressDialog.activityIndicator startAnimating];
	self.progressDialog.progressBar.hidden = YES;
	[self.progressDialog show];
	if([WSUtils CanConnectToURL:[[WSPE_ConnectionStrings instance] Get:@"PrintCheckURL"]]){
		[connManager initPOST:[[WSPE_ConnectionStrings instance] Get:@"PrintURL"] postData:[NSString stringWithFormat:@"xmlData=%@", [notification object]] tag:@"print"];
	}
	else {
		UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"Unable to create PDF" message:@"Your iPad is currently unable to connect to the Internet, which is required to create a PDF." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        al.tag = 999;
		[al show];
	}
}
-(void)dataLoaded:(NSNotification *)notification{
	WSKVPair *connPair = (WSKVPair *)[notification object];
	if([connPair.key isEqualToString:@"print"]){
		[self.progressDialog close];
		NSMutableData *returnData = (NSMutableData *)connPair.dataValue;
		if([returnData writeToFile:[NSString stringWithFormat:@"%@/Printout.pdf", [WSUtils GetDocsPath]] atomically:YES]){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PDF Created!" message:@"Your PDF has been successfully created and saved to your iPad, what would you like to do now?" delegate:self cancelButtonTitle:@"Nothing" otherButtonTitles:nil];
			alert.tag = 2;
			[alert addButtonWithTitle:@"Open the PDF"];
			[alert addButtonWithTitle:@"Email the PDF"];
			[alert show];
            [alert release];
		}
	}
}
-(void)connectionFailed:(NSNotification *)notification{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed to create PDF" message:@"There was an error creating your PDF, please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alert.tag = 9999;
    [alert show];
    [alert release];
}
-(void)checkLaunchOpportunity:(NSNotification *)notification{
    NSString *tagID = (NSString *)[notification object];
    BOOL foundTag = [self findAppletByTag:tagID];
	if(!foundTag){
        MH_SAM_PE_CRM_Opportunity *opp = [[dm getCRMOpportunitiesList] getObjectByID:tagID];
        if(opp != nil){
            WSBoolean *outOfDate = [opp GetPropAsWSBoolean:@"OutOfDate" pToVal:@"IT"];
            if(outOfDate != nil && outOfDate.value == YES)
            {
                self.activeOpportunity = opp;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Record out of date!" message:@"The record is out of date, what would you like to do?\n\nThis could be caused by another user downloading this record, rather than it having been updated on your CRM. Please ensure a record is synched to your CRM before downloading it to another iPad." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                alert.tag = 3;
                [alert addButtonWithTitle:@"Launch it anyway"];
                [alert addButtonWithTitle:@"Download the latest version"];
                [alert show];
                [alert release];
            }
            else
                [self launchOpportunity:opp];
        }
    }
}
-(void)launchOpportunity:(WSCRMOpportunity *)opp{
    NSString *filename = [opp GetProp:@"BlobData"];
    NSString *noaccess = [opp GetProp:@"BlobDataNoAccess"];
    NSString *missing = [opp GetProp:@"BlobDataMissing"];
    if([noaccess isEqualToString:@""] && [missing isEqualToString:@""]){
        WSXMLObject *blobData = [[WSXMLObject alloc] init:[WSUtils StringFromDocumentsFile:filename]];
        WSXMLObject *blobDataXml = [[blobData Get:@"xml"] retain];
        if(blobDataXml == nil) blobDataXml = [blobData retain];
        [blobData release];
        BlueSheetViewController *bsViewController = [[BlueSheetViewController alloc] initWithNibNameAndXML:@"BlueSheetView" bundle:[NSBundle mainBundle] XML:blobDataXml AppletID:[opp GetProp:@"Id"]];
        [blobDataXml release];
        bsViewController.view.backgroundColor = [WSUtils UIColorFromHex:@"BFD1EE"];
        if([leftAppletTabs_Controller.loadControllers count] > [rightAppletTabs_Controller.loadControllers count])
        {
            if([rightAppletTabs_Controller.loadControllers count] < 2)
                [rightAppletTabs_Controller addTabItem:[opp GetProp:@"Name"] tag:[opp GetProp:@"Id"] imageFile:@"BlueSheet.png" viewController:bsViewController];
        }
        else {
            if([leftAppletTabs_Controller.loadControllers count] < 2)
                [leftAppletTabs_Controller addTabItem:[opp GetProp:@"Name"] tag:[opp GetProp:@"Id"] imageFile:@"BlueSheet.png" viewController:bsViewController];
        }
        [bsViewController release];
    }
    else if(![noaccess isEqualToString:@""]){
        UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"No Access" message:[NSString stringWithFormat:@"%@\n%@", [WSUtils URLDecode:noaccess], @"Once the appropriate changes have been made to your user account, please re-download this record."] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        al.tag = 999;
        [al show];
    }
    else if(![missing isEqualToString:@""]){
        UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"No Data" message:[WSUtils URLDecode:missing] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        al.tag = 999;
        [al show];
    }
    else{
        UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error when loading the record data, please download this record again from your CRM" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        al.tag = 999;
        [al show];
    }
}
-(void)saveOpportunityBlobXML:(NSNotification *)notification{
    NSString *path = [WSUtils GetFileInDocsWhichContains:[[notification object] key]];
    [WSUtils WriteStringToFile:path stringToSave:[[notification object] value]];
	UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"Information" message:@"Your Blue Sheet has been saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    al.tag = 999;
	[al show];
}
-(void)closeApplet:(NSNotification *)notification{
	currentDM = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:[notification object]];
    NSString *currData = [self.currentDM createSaveXML];
	if(![currData isEqualToString:self.currentDM.lastSave] && !self.currentDM.readOnly.value){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Close" message:@"You have unsaved data" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		alert.tag = 1;
		[alert addButtonWithTitle:@"Save & Close"];
		[alert addButtonWithTitle:@"Close"];
		[alert show];
		[alert release];
	}
	else
		[self closeTheCurrentApplet];
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(alertView.tag == 1){
		BOOL doClose = YES;
		if(buttonIndex == 0)
			doClose = NO;
		else if(buttonIndex == 1)
			[self.currentDM saveData];
		if(doClose)
			[self closeTheCurrentApplet];
		currentDM = nil;
	}
	else if(alertView.tag == 2){
		if(buttonIndex == 1){
			[self showWebBrowser:[NSString stringWithFormat:@"%@/%@", [WSUtils GetDocsPath], @"Printout.pdf"] title:@"View your PDF" mode:@"PDF"];
		}
		else if(buttonIndex == 2)
			[self showEmailDialog:@"" attachment:@"Printout.pdf" attachmentType:@"PDF"];
	}
    else if(alertView.tag == 3){
        if(buttonIndex == 1){
            [self launchOpportunity:self.activeOpportunity];
            self.activeOpportunity = nil;
        }
        else if(buttonIndex == 2){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LaunchSyncDialog" object:[self.activeOpportunity GetProp:@"Id"]];
            self.activeOpportunity = nil;
        }
    }
}
-(void)closeTheCurrentApplet{
	for(int l = 0; l < [leftAppletTabs_Controller.loadControllers count]; l++){
		WSDraggableTabBarButtonController * btn_Controller = (WSDraggableTabBarButtonController *)[leftAppletTabs_Controller.loadControllers objectAtIndex:l];
		if([btn_Controller.ID isEqualToString:self.currentDM.ID]){
			[leftAppletTabs_Controller removeTabByID:self.currentDM.ID];
			break;
		}
	}
	for(int r = 0; r < [rightAppletTabs_Controller.loadControllers count]; r++){
		WSDraggableTabBarButtonController * btn_Controller = (WSDraggableTabBarButtonController *)[rightAppletTabs_Controller.loadControllers objectAtIndex:r];
		if([btn_Controller.ID isEqualToString:self.currentDM.ID]){
			[rightAppletTabs_Controller removeTabByID:self.currentDM.ID];
			break;
		}
	}
	[[WSDataModelManager instance] deleteByID:self.currentDM.ID];
}
-(BOOL)findAppletByTag:(NSString *)tag{
	BOOL foundTag = NO;
	for(int l = 0; l < [leftAppletTabs_Controller.loadControllers count]; l++){
		WSDraggableTabBarButtonController * btn_Controller = (WSDraggableTabBarButtonController *)[leftAppletTabs_Controller.loadControllers objectAtIndex:l];
		if([btn_Controller.tag isEqualToString:tag]){
			foundTag = YES;
		}
	}
	for(int r = 0; r < [rightAppletTabs_Controller.loadControllers count]; r++){
		WSDraggableTabBarButtonController * btn_Controller = (WSDraggableTabBarButtonController *)[rightAppletTabs_Controller.loadControllers objectAtIndex:r];
		if([btn_Controller.tag isEqualToString:tag]){
			foundTag = YES;
		}
	}
	return foundTag;
}
-(void)dealloc{
    [super dealloc];
    [connManager release];
    [currentDM release];
    [progressDialog release];
}
@end
