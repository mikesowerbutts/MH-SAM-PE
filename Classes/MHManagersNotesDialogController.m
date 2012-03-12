//
//  MHManagersNotesDialogController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 16/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHManagersNotesDialogController.h"
#import "WSXMLObject.h"
#import "BlueSheetDataModel.h"
@implementation MHManagersNotesDialogController
@synthesize tvControllers, dateController, date;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewFocussed:) name:@"textViewFocussed" object:nil];
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	WSXMLObject *mnADN = [dm.applicationData Get:@"Content/ManagersNotesSections"];
	WSXMLObject *mnFDN = [dm.fileData Get:@"ManagersNotes"];
	if(mnADN != nil){
		self.tvControllers = [[NSMutableArray alloc] initWithCapacity:[mnADN.children count]];
		int yP = 10;
		int padding = 5;
		int xP = 5;
		for(int i = 0; i < [mnADN.children count]; i++){
			WSXMLObject *mnADNC = [mnADN GetByIndex:i];
			WSXMLObject *mnFDNC = [mnFDN GetByAttributeValue:@"ID" attValue:[NSString stringWithFormat:@"%i", (i + 1)]];
			if(mnADNC != nil){
				WSLabel *lbl = [[WSLabel alloc] initWithFrame:CGRectMake(xP, yP, self.dialogView.frame.size.width - (xP * 10), 25) ID:ID];
				[lbl setValue:[dm.transManager getLabel:[mnADNC GetAttribute:@"Label"]]];
				lbl.borders = @"";
				lbl.backgroundColor = [UIColor clearColor];
				WSTextView *tv = [[WSTextView alloc] initWithFrame:CGRectMake(xP, yP + lbl.frame.size.height + padding, lbl.frame.size.width, 55)];
				tv.delegate = self;
				WSTextViewController *tvC = [[WSTextViewController alloc] initWithFieldAndValue:tv value:[WSUtils URLDecode:[mnFDNC GetAttribute:@"Notes"]]];
				
				[self.tvControllers addObject:tvC];
				[self.scrollView addSubview:lbl];
				[self.scrollView addSubview:tv];
				yP += lbl.frame.size.height + tv.frame.size.height + (padding * 2);
			}
		}
		NSString *dateStr = [[dm.fileData Get:@"ManagerReviewDate"] innerXML];
		self.dateController = [[WSDateFieldController alloc] initWithFieldAndDate:date currentDate:dateStr != nil ? [WSUtils URLDecode:dateStr] : [[WSDate getWSDateNow] retain]];
		yP += date.frame.size.height + padding;
		self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, yP);
	}
	return self;
}
-(void)textViewFocussed:(NSNotification *)notification{
	for(int i = 0; i < [self.tvControllers count]; i++){
		if([self.tvControllers objectAtIndex:i] == [notification object]){
			WSTextViewController *tvC = [self.tvControllers objectAtIndex:i];
			WSTextView *tv = [tvC textView];
			[self.scrollView scrollRectToVisible:tv.frame animated:YES];
			break;
		}
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		WSXMLObject *fdN = [[dm.fileData Get:@"ManagersNotes"] retain];
		if(fdN == nil)
			[dm.fileData AddChild:[[WSXMLObject alloc] init:@"<ManagersNotes/>"]];
		fdN = [dm.fileData Get:@"ManagersNotes"];
		[[fdN rootElement] removeAllChildren];
		WSXMLObject *mnADN = [[dm.applicationData Get:@"Content/ManagersNotesSections"] retain];
		for(int i = 0; i < [mnADN.children count]; i++){
			WSTextViewController *tvC = self.tvControllers.count >= i ? [self.tvControllers objectAtIndex:i] : nil;
			if(tvC != nil){
				WSXMLObject *mnADNC = [mnADN GetByIndex:i];
				NSString *lbl = [dm.transManager getLabel:[mnADNC GetAttribute:@"Label"]];
				WSXMLObject *ntN = [[WSXMLObject alloc] init:[NSString stringWithFormat:@"<Note ID=\"%i\" Label=\"%@\" Notes=\"%@\" />", (i + 1), lbl, [WSUtils URLEncode:tvC.textView.textView.text]]];
				[fdN AddChild:ntN];
                [ntN release];
			}
		}
		[dm.fileData ReplaceChildNode:@"ManagersNotes" replacementNode:fdN];
		[dm.fileData SetNodeValue:@"ManagerReviewDate" newValue:[self.dateController.date getXMLFormattedDate]];
	}
	for(int i = 0; i < [self.scrollView.subviews count]; i++)
		[[self.scrollView.subviews objectAtIndex:i] removeFromSuperview];
	[super isClosing:mode];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkManagersNotes" object:nil];
	return YES;
}
-(void)dealloc{
	[tvControllers release];
	[super dealloc];
}
@end
