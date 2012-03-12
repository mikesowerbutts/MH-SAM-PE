//
//  WSListPickerController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 07/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPopoverViewController.h"
#import "WSListPickerField.h"
#import "WSTableViewController.h"
#import "WSFieldController.h"
#import "WSKVPairList.h"
#import "WSDataPicker.h"

@interface WSListPickerController : WSFieldController<UITextFieldDelegate, UITableViewDelegate> {
	WSPopoverViewController *popoverController;
	WSTableViewController *tableViewController;
	WSKVPairList *listData;
	BOOL multiSelect;
	WSKVPairList *selectedPairs;
	WSDataPicker *dataPicker;
}
@property(nonatomic, retain)WSPopoverViewController *popoverController;
@property(nonatomic, retain)WSTableViewController *tableViewController;
@property(nonatomic, retain)WSKVPairList *listData;
@property(nonatomic)BOOL multiSelect;
@property(nonatomic, retain)WSKVPairList *selectedPairs;

-(id)initWithFieldListDataAndValue:(WSListPickerField *)theTextBox listData:(WSKVPairList *)theListData value:(WSKVPair *)theValue multiSelect:(BOOL)ms;
-(void)updateTextBox:(WSKVPairList *)selPairs;
@end
