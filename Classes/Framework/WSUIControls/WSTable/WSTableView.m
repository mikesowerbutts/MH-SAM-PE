//
//  WSTableView.m
//  BlueSheet
//
//  Created by Toby Widdowson on 10/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTableView.h"
#import "WSUtils.h"
#import "WSStyle.h"

@implementation WSTableView
-(void)drawRect:(CGRect)rect{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(ctx, [WSUtils UIColorFromHex:[[WSStyle instance] getTableLineHex]].CGColor);
	CGContextSetLineWidth(ctx, 1);
	CGRect theRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
	CGContextStrokeRect(ctx, theRect);
	[super drawRect:rect];
}
@end
