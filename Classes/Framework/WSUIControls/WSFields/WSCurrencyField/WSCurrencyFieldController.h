//
//  WSCurrencyFieldController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNumberFieldController.h"
#import "WSCurrency.h"
#import "WSNumberField.h"
@interface WSCurrencyFieldController : WSFieldController {
	WSCurrency *currency;
}
@property(nonatomic, retain)WSCurrency *currency;
-(id)initWithFieldAndValue:(WSNumberField *)theTextBox value:(NSString *)theValue;
@end
