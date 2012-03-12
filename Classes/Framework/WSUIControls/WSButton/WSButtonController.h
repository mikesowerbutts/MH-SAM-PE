//
//  WSButtonController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 02/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSButton.h"

@interface WSButtonController : UIViewController {
	WSButton *button;
	UIViewController *associatedViewController;
	NSString *tag;
	BOOL selected;
}
@property(nonatomic)BOOL selected;
@property(nonatomic, retain)NSString *tag;
@property(nonatomic, retain)WSButton *button;
@property(nonatomic, retain)UIViewController *associatedViewController;

-(id)initWithButton:(WSButton *)theButton;
-(void)toggleSelected;
-(void)additionalSetup;
-(void)touchUpInside;
-(void)touchUpInside:(NSString *)notification;
@end
