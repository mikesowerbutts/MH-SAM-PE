    //
//  WSPopoverViewController.m
//  BlueSheet
//
//  Created by Toby Widdowson on 05/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDateFieldController.h"


@implementation WSPopoverViewController
@synthesize popoverContent, popoverController;
@synthesize dispRect, dispView, cancelBtn, okBtn, cancelBtn_Controller, okBtn_Controller, result, dialogView;
-(id)initWithSubControls:(UIView *)theDispView displayRect:(CGRect)theDispRect displaySource:(CGRect)theDispSource subControls:(NSMutableArray *)subCons
{
	[self init:theDispView displayRect:theDispRect subControls:subCons];
	[self showPopoverFromRect:theDispSource];
	return self;
}
-(id)initWithSubControlsDontShow:(UIView *)theDispView displayRect:(CGRect)theDispRect subControls:(NSMutableArray *)subCons
{
	[self init:theDispView displayRect:theDispRect subControls:subCons];
	return self;
}
-(void)init:(UIView *)theDispView displayRect:(CGRect)theDispRect subControls:(NSMutableArray *)subCons
{
	dispRect = theDispRect;
	dispView = theDispView;
	popoverContent = [[UIViewController alloc] init];
	UIView *popoverView = [[UIView alloc] initWithFrame:dispRect];
	popoverContent.view = popoverView;
	popoverContent.contentSizeForViewInPopover = dispRect.size;
	for(int i = 0; i < subCons.count; i++){
		[popoverContent.view addSubview:[subCons objectAtIndex:i]];
	}
	popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
	[popoverController setDelegate:self];
}
-(id)initWithXIBDontShow:(NSString *)theNibName mainView:(UIView *)theDispView{
	
	NSArray *nibObjs = [[NSBundle mainBundle] loadNibNamed:theNibName owner:self options:nil];
	UIView *nibView = [nibObjs objectAtIndex:0];
	self.dialogView = nibView;
	NSInteger padding = 5;
	NSInteger btnWidth = 100;
	NSInteger btnHeight = 25;
	dispRect = CGRectMake(0, 0, dialogView.frame.size.width, dialogView.frame.size.height);
	[cancelBtn initNormal];
	[cancelBtn.label setValue:@"Cancel"];
	cancelBtn_Controller = [[WSButtonController alloc] initWithButton:cancelBtn];
	[okBtn initNormal];
	okBtn_Controller = [[WSButtonController alloc] initWithButton:okBtn];
	[okBtn.label setValue:@"OK"];
	NSMutableArray *subCons = [[[NSMutableArray alloc] init] autorelease];
	[subCons addObject:self.dialogView];
	[self init:theDispView displayRect:dispRect subControls:subCons];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(okCancelBtnTouchUpInside:) name:@"btnTouchUpInside" object:nil];
	return self;
}
-(void)okCancelBtnTouchUpInside:(NSNotification*)notification{
	WSButtonController *btnController = (WSButtonController *)[notification object];
	if(btnController == okBtn_Controller){
		result = YES;
		[self isClosing:@"OK"];
		[popoverController dismissPopoverAnimated:YES];
	}
	else if(btnController == cancelBtn_Controller){
		result = NO;
		[self isClosing:@"CANCEL"];
		[popoverController dismissPopoverAnimated:YES];
	}
}
-(void)isClosing:(NSString *)mode{
	
}

-(void)showPopoverFromRect:(CGRect)sourceRect{
	[popoverController presentPopoverFromRect:sourceRect inView:dispView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[popoverController setPopoverContentSize:dispRect.size];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        popoverContent = [[UIViewController alloc] init];
		UIView *popoverView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,400)];
		popoverContent.view = popoverView;
		popoverContent.contentSizeForViewInPopover = CGSizeMake(300,200);
		popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	NSLog(@"dealloc WSPopoverViewController");
    [super dealloc];
	[popoverContent release];
	[dispView release]; 
	[cancelBtn release];
	[okBtn release];
	[cancelBtn_Controller release];
	[okBtn_Controller release];
	[dialogView release];
	[popoverController release];
}

@end
