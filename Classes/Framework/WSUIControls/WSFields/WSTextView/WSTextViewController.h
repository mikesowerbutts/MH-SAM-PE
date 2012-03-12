//
//  WSTextViewController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSFieldController.h"
#import "WSTextView.h"
@interface WSTextViewController : WSFieldController<UITextViewDelegate> {
	WSTextView *textView;
}
@property(nonatomic, retain)WSTextView *textView;
-(id)initWithFieldAndValue:(WSTextView *)theTextView value:(NSString *)theValue;
@end
