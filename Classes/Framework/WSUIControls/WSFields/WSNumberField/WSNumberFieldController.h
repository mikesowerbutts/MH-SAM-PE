//
//  WSNumberFieldController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNumberField.h"
#import "WSFieldController.h"

@interface WSNumberFieldController : WSFieldController<UITextFieldDelegate> {
	NSString *thouSep;
	NSInteger decPlaces;
	NSInteger maxVal;
	NSInteger minVal;
	NSNumberFormatter *numFmtr;
}
@property(nonatomic, retain)NSNumberFormatter *numFmtr;
-(void)doinit:(WSNumberField *)theTextBox;
-(void)initWithFieldAndValue:(WSNumberField *)theTextBox value:(NSString *)theValue;
@end
