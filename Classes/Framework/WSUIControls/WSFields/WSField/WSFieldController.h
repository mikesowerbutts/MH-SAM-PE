//
//  WSFieldController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 21/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTextField.h"

@interface WSFieldController : UIViewController {
	UIViewController *delegate;
	NSString *saveNodeTemplate;
	WSTextField *textBox;
}
@property(nonatomic, retain)UIViewController *delegate;
@property(nonatomic, retain)NSString *saveNodeTemplate;
-(NSString *)createSave;
@end
