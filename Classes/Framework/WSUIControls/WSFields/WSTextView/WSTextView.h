//
//  WSTextView.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSUITextView.h"

@interface WSTextView : UIControl {
	WSUITextView *textView;
	IBOutlet UIViewController *delegate;
}
@property(nonatomic, retain)WSUITextView *textView;
@property(nonatomic, retain)IBOutlet UIViewController *delegate;

-(id)initWithString:(NSString *)theValue;
@end
