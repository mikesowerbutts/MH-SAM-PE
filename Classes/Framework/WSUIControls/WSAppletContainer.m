//
//  WSAppletContainer.m
//  CRMSync
//
//  Created by Toby Widdowson on 06/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSAppletContainer.h"


@implementation WSAppletContainer
@synthesize scrollView, appletViewController, showTabBtn, showTabBtn_Controller, showTabBtnTimer, owningBtn_Controller;
-(id)initWithFrameAndApplet:(CGRect)theFrame applet:(UIViewController *)theAppletViewController{
	[super initWithFrame:theFrame];
	self.backgroundColor = [UIColor redColor];
	self.scrollView = [[WSScrollView alloc] initWithFrame:CGRectMake(0, 0, theFrame.size.width, theFrame.size.height)];
	scrollView.delegate = self;
	scrollView.backgroundColor = [UIColor blueColor];
	[self addSubview:scrollView];
	self.appletViewController = theAppletViewController;
	[scrollView addSubview:appletViewController.view];
	self.showTabBtn = [[WSButton alloc] initWithFrame:CGRectMake(1024 - 60, 0, 60, 60)];
	showTabBtn_Controller = [[WSButtonController alloc] initWithButton:showTabBtn];
	showTabBtn.label.backgroundColor = [UIColor purpleColor];
	[showTabBtn.label setValue:@"Show Tab"];
	showTabBtn.label.hidden = YES;
	showTabBtn.highlight.hidden = YES;
	[scrollView addSubview:showTabBtn];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showShowTabBtn:) name:@"btnTouchUpInside" object:nil];
	return self;
}
-(void)showShowTabBtn:(NSNotification *)notification{
	WSButtonController *btn_Con = (WSButtonController *)[notification object];
	if(btn_Con == showTabBtn_Controller){
		self.showTabBtnTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hideShowTabBtn) userInfo:nil repeats:NO];
		if(btn_Con.button.label.hidden == NO){
			[owningBtn_Controller revealBtn];
			btn_Con.button.label.hidden = NO;
			btn_Con.button.highlight.hidden = NO;
		}
		else{
			btn_Con.button.label.hidden = NO;
			btn_Con.button.highlight.hidden = NO;
		}
	}
}
-(void)hideShowTabBtn{
	showTabBtn.label.hidden = YES;
	showTabBtn.highlight.hidden = YES;
}
-(void)dealloc{
	[super dealloc];
	[scrollView release];
	[appletViewController release];
}
@end
