//
//  WSAppletContainer.h
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSScrollView.h"
#import "WSButton.h"
#import "WSButtonController.h"

@interface WSAppletContainer : UIView {
	WSScrollView *scrollView;
	UIViewController *appletViewController;
	WSButton *showTabBtn;
	WSButtonController *showTabBtn_Controller;
	NSTimer *showTabBtnTimer;
	UIViewController *owningBtn_Controller;
}
@property(nonatomic, retain)WSScrollView *scrollView;
@property(nonatomic, retain)WSButton *showTabBtn;
@property(nonatomic, retain)WSButtonController *showTabBtn_Controller;
@property(nonatomic, retain)UIViewController *appletViewController;
@property(nonatomic, retain)NSTimer *showTabBtnTimer;
@property(nonatomic, retain)UIViewController *owningBtn_Controller;

-(id)initWithFrameAndApplet:(CGRect)theFrame applet:(UIViewController *)theAppletViewController;
@end
