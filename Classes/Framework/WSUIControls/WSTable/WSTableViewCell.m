//
//  WSTableViewCell.m
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTableViewCell.h"
#import "WSColumnInfo.h"
#import "WSUtils.h"
#import "WSStyle.h"
#import "WSLabel.h"
@implementation WSTableViewCell
@synthesize ID;
-(void)removeSubViews{
	NSArray *subviews = [[NSArray alloc] initWithArray:self.contentView.subviews];
	for(UIView *subview in subviews){
		[subview removeFromSuperview];
	}
	[subviews release];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	WSLabel *lbl = nil;
	CGPoint touchLoc = [[touches anyObject] locationInView:self];
	for(int i = 0; i < [self.contentView.subviews count]; i++){
		CGRect frm = [[self.contentView.subviews objectAtIndex:i] frame];
		if(CGRectContainsPoint(frm, touchLoc)){
			lbl = (WSLabel *)[self.contentView.subviews objectAtIndex:i];
			break;
		}
	}
	if(lbl != nil){
		[lbl touchesBegan:touches withEvent:event];
	}
}
@end
