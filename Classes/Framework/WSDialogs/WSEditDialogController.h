//
//  WSEditDialogController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSPopoverViewController.h"

@interface WSEditDialogController : WSPopoverViewController {
	NSString *dataObjID;
}
@property(nonatomic, retain)NSString *dataObjID;
-(void)saveData;
-(void)setupDialog:(NSString *)theDataObjID;
@end
