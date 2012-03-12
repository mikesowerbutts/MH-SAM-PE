//
//  WSTextView.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTextView.h"
#import "WSUtils.h"
#import "WSStyle.h"
#import "WSUITextView.h"

@implementation WSTextView
@synthesize delegate, textView;
-(id)initWithString:(NSString *)theValue{
	self.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBGHex]];
	textView = [[WSUITextView alloc] initWithFrame:CGRectMake(1, 3, self.frame.size.width - 2, self.frame.size.height - 6)];
	textView.text = [theValue stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self addSubview:textView];
	textView.delegate = self.delegate;
	return self;
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
-(void)dealloc{
	[super dealloc];
	[textView release];
}
@end
