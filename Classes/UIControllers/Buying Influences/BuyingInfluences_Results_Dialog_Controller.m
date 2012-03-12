    //
//  BuyingInfluences_Results_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 10/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "BuyingInfluences_Results_Dialog_Controller.h"
#import "BlueSheetDataModel.h"

@implementation BuyingInfluences_Results_Dialog_Controller
@synthesize description, description_Controller, influence;
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSInfluence *infTemp = [[bluesheetDataModel getInfluences] getObjectByID:theDataObjID];
		self.influence = [[infTemp copyObject] autorelease];//Leak
	}
	else{
		self.influence = [[[BSInfluence alloc] init:theID] autorelease];//Leak
	}
	if(influence != nil){
		if(self.description_Controller == nil)
			self.description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:description value:influence.resultDescription] autorelease];
		else
			self.description_Controller.value = influence.resultDescription;
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		influence.resultDescription = description.textView.text;
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		[bluesheetDataModel updateObjectList:[bluesheetDataModel getInfluences] updatedObject:influence notificationType:@"Influence"];
	}
	[super isClosing:mode];
	return YES;
}
- (void)dealloc {
    [super dealloc];
	[description release];
	[description_Controller release];
	[influence release];
}
@end
