//
//  WSAppViewController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSAppViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate> {
	IBOutlet UIScrollView *scrollView;
	CGRect keyboardBounds;
	
	UIView *activeControl;
}
@property(nonatomic, retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic)CGRect keyboardBounds;
@property(nonatomic, retain)UIView *activeControl;
@end
