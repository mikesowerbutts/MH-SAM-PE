//
//  WSEditDialogController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSEditDialogController.h"


@implementation WSEditDialogController
@synthesize dataObjID;
-(void)showPopoverFromRect:(CGRect)sourceRect{
	popoverContent.modalInPopover = YES;
	[super showPopoverFromRect:sourceRect];
}
-(void)setupDialog:(NSString *)theDataObjID{
	dataObjID = theDataObjID;
}
-(void)saveData{
	
}
@end
