//
//  MHNotes.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/03/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHNotesDialogController.h"
#import "BlueSheetDataModel.h"

@implementation MHNotesDialogController
@synthesize tv, tvC;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	WSXMLObject *notesN = [dm.fileData Get:@"OpportunityNotes"];
	self.tvC = [[WSTextViewController alloc] initWithFieldAndValue:tv value:notesN != nil ? [WSUtils URLDecode:[notesN innerXML]] : @""];
	
	return self;
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		if([dm.fileData Get:@"OpportunityNotes"] == nil)
			[dm.fileData AddChild:[[WSXMLObject alloc] init:@"<OpportunityNotes/>"]];
        NSString *newVal = [WSUtils URLEncode:self.tv.textView.text];
		[dm.fileData SetNodeValue:@"OpportunityNotes" newValue:newVal];
	}
	[super isClosing:mode];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"checkAdditionalNotes" object:nil];
	return YES;
}
-(void)dealloc{
	[tv release];
	[tvC release];
	[super dealloc];
}

@end
