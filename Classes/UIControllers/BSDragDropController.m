    //
//  BSDragDropController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 17/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "BSDragDropController.h"


@implementation BSDragDropController
@synthesize dragDrop, mainView, currCopy;
-(id)initWithDragDrop:(BSDragDrop *)theDragDrop{
	self.dragDrop = theDragDrop;
	[self.dragDrop init];
	self.mainView = self.dragDrop.superview;
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnDragged:) name:@"MHFlagDragging" object:nil];
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnReleased) name:@"MHFlagDropped" object:nil];
	return self;
}
-(void)btnReleased{
	NSLog(@"btnReleased Controller");
	self.currCopy = nil;
}
-(void)btnDragged:(NSNotification *)notification{
	NSArray *objs = [notification object];
	MHFlagButtonController *btnCon = (MHFlagButtonController *)[objs objectAtIndex:0];
	UIEvent *event = [objs objectAtIndex:1];
	CGPoint point = [[[event allTouches] anyObject] locationInView:self.mainView];
	if(self.currCopy == nil){
		self.currCopy = [btnCon copy];
		self.currCopy.dragBtn.imageView.hidden = NO;
		[self.dragDrop.superview addSubview:self.currCopy.dragBtn];
		[self.dragDrop.superview bringSubviewToFront:self.currCopy.dragBtn];
	}
	self.currCopy.dragBtn.center = point;
}

- (void)dealloc {
    [super dealloc];
	[dragDrop release];
	[currCopy release];
}
@end
