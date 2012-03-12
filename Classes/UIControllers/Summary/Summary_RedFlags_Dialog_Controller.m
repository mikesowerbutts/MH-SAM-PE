    //
//  RedFlags_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "Summary_RedFlags_Dialog_Controller.h"
#import "BlueSheetDataModel.h"

@implementation Summary_RedFlags_Dialog_Controller
@synthesize redFlag, description_Controller, description;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	return self;
}
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		//NSLog(@"theDataObjID: %@", theDataObjID);
		BSRedFlag *rfTemp = [[bluesheetDataModel getRedFlags] getObjectByID:theDataObjID];
		self.redFlag = [[rfTemp copyObject] autorelease];
	}
	else
		self.redFlag = [[[BSRedFlag alloc] init:theID] autorelease]; 
	if(redFlag != nil)
		self.description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:description value:redFlag.description] autorelease];
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		redFlag.description = description.textView.text;
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		[bluesheetDataModel updateObjectList:[bluesheetDataModel getRedFlags] updatedObject:redFlag notificationType:@"RedFlag"];
	}
	[super isClosing:mode];
	return YES;
}
- (void)dealloc {
    [super dealloc];
	[redFlag release];
	[description release];
	[description_Controller release];
}


@end
