//
//  WSButtonHighlight.m
//  CRMSync
//
//  Created by Toby Widdowson on 04/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSButtonHighlight.h"
#import "WSStyle.h"
#import "WSUtils.h"

@implementation WSButtonHighlight
@synthesize highlightColor;
-(id)initWithFrame:(CGRect)frame{
	[super initWithFrame:frame];
	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;
	self.highlightColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnHighlightHex]];
	return self;
}
-(void)drawRect:(CGRect)rect{
	[super drawRect:rect];
	//[self reDraw];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGPoint startPoint, endPoint;
	startPoint.x = self.frame.size.width / 2;
	startPoint.y = 0;
	endPoint.x = self.frame.size.width / 2;
	endPoint.y = self.frame.size.height / 2;
	CGContextDrawLinearGradient(ctx, [self createGradient], startPoint, endPoint, 0);
}
-(CGGradientRef)createGradient{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat *highlightComps = CGColorGetComponents([highlightColor CGColor]);
	CGFloat locations[] = {0.0, 0.5, 1.0};
	size_t locationCount = 3;
	CGFloat colorList[] = {
		highlightComps[0], highlightComps[1], highlightComps[2], 0.8,
		highlightComps[0], highlightComps[1], highlightComps[2], 0.4,
		highlightComps[0], highlightComps[1], highlightComps[2], 0.1
	};
	return CGGradientCreateWithColorComponents(colorSpace, colorList, locations, locationCount);
}
-(void)reDraw{
	
}
- (void)dealloc {
    [super dealloc];
}


@end
