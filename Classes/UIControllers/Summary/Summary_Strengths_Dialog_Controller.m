    //
//  Strengths_Dialog_Controller.m
//  BlueSheet
//
//  Created by Mike Sowerbutts on 20/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "Summary_Strengths_Dialog_Controller.h"
#import "BlueSheetDataModel.h"

@implementation Summary_Strengths_Dialog_Controller
@synthesize strength, description_Controller, description;
-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID{
	[super initWithXIBAndIDDontShow:theNibName mainView:theDispView ID:theID];
	return self;
}
-(void)setupDialog:(NSString *)theDataObjID ID:(NSString *)theID{
	[super setupDialog:theDataObjID ID:theID];
	BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
	if(theDataObjID != nil){
		BSStrength *strTemp = [[bluesheetDataModel getStrengths] getObjectByID:theDataObjID];
		self.strength = [[strTemp copyObject] autorelease];
	}
	else{
		self.strength = [[[BSStrength alloc] init:theID] autorelease];
	}
	if(strength != nil){
		self.description_Controller = [[[WSTextViewController alloc] initWithFieldAndValue:description value:strength.description] autorelease];
	}
}
-(BOOL)isClosing:(NSString *)mode{
	if([mode isEqualToString:@"OK"]){
		strength.description = description.textView.text;
		BlueSheetDataModel *bluesheetDataModel = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:ID];
		[bluesheetDataModel updateObjectList:[bluesheetDataModel getStrengths] updatedObject:strength notificationType:@"Strength"];
	}
	[super isClosing:mode];
	return YES;
}

- (void)dealloc {
    [super dealloc];
	[strength release];
	[description release];
	[description_Controller release];
}


@end
