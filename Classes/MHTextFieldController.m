    //
//  MHTextFieldController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTextFieldController.h"
#import "BlueSheetDataModel.h"
#import "BSDragObjectList.h"
#import "BSDragObject.h"

@implementation MHTextFieldController
@synthesize flagID, flagBtn, flagController;
-(id)initWithFieldValueAndFlagID:(WSTextField *)theTextBox value:(NSString *)theValue flagID:(NSString *)theFlagID{	
	self.textBox = theTextBox;
	self.textBox.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.textBox.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[textBox setBorderStyle:UITextBorderStyleRoundedRect];
	textBox.borderStyle = UITextBorderStyleRoundedRect;
	textBox.text = [theValue stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	self.flagID = theFlagID;
	[self checkFlag];
	return self;
}
-(void)checkFlag{
	BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[self.textBox.delegate getID]];
	BSDragObject *d = [dm.flagsList getObjectByID:self.flagID];
	if(d != nil){
		CGPoint center = CGPointMake(self.textBox.frame.size.width * [d.xRatio floatValue], self.textBox.frame.size.height * [d.yRatio floatValue]);
		UIImage *img = [UIImage imageNamed:[d getImage]];
		self.flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
		self.flagBtn.center = center;
		self.flagController = [[WSDraggableButtonController alloc] initWithButtonViewAndRect:self.flagBtn containerView:self.textBox.superview dragRect:CGRectMake(0, 0, 1024, 768) ID:@""];
		[textBox addSubview:self.flagBtn];
	}
}
- (void)dealloc {
    [super dealloc];
}
@end
