//
//  WSToggleButton.m
//  BlueSheet
//
//  Created by Toby Widdowson on 22/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSToggleButton.h"
#import "WSUtils.h"
#import "WSStyle.h"

@implementation WSToggleButton
-(void)build:(CGRect)frame{
	NSLog(@"build");
	self.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
	imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 3, frame.size.width - 2, frame.size.height - 6)];
	[self addSubview:imageView];
	imageView.backgroundColor = [UIColor whiteColor];
	label = [[WSLabel alloc] initWithFrame:CGRectMake(1, 3, frame.size.width - 2, frame.size.height - 6)];
	[self addSubview:label];
	label.hidden = YES;
	label.textAlignment = UITextAlignmentCenter;
	label.backgroundColor = [UIColor whiteColor];
	label.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnFGHex]];
}
-(void)drawRect:(CGRect)rect{
	UIImageView *TLCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderTLCorner.png"]];
	TLCorner.frame = CGRectMake(0, 0, 6, 6);
	[self addSubview:TLCorner];
	
	UIImageView *TRCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderTRCorner.png"]];
	TRCorner.frame = CGRectMake(self.frame.size.width - 6, 0, 6, 6);
	[self addSubview:TRCorner];
	
	UIImageView *BLCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderBLCorner.png"]];
	BLCorner.frame = CGRectMake(0, self.frame.size.height - 6, 6, 6);
	[self addSubview:BLCorner];
	
	UIImageView *BRCorner = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderBRCorner.png"]];
	BRCorner.frame = CGRectMake(self.frame.size.width - 6, self.frame.size.height - 6, 6, 6);
	[self addSubview:BRCorner];
	
	UIImageView *Top = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderTop.png"]];
	Top.frame = CGRectMake(6, 0, self.frame.size.width - 12, 3);
	[self addSubview:Top];
	
	UIImageView *Bottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderBottom.png"]];
	Bottom.frame = CGRectMake(6, self.frame.size.height - 3, self.frame.size.width - 12, 3);
	[self addSubview:Bottom];
	
	UIImageView *Left = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderSide.png"]];
	Left.frame = CGRectMake(0, 6, 1, self.frame.size.height - 12);
	[self addSubview:Left];
	
	UIImageView *Right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WSTextViewBorderSide.png"]];
	Right.frame = CGRectMake(self.frame.size.width - 1, 6, 1, self.frame.size.height - 12);
	[self addSubview:Right];
}
@end
