//
//  WSLabel.m
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSLabel.h"
#import "WSUtils.h"
#import "WSStyle.h"

@implementation WSLabel
@synthesize padding, borders;

-(id)initWithFrame:(CGRect)frame{
	borders = [[NSString alloc] initWithString:@""];
	return [super initWithFrame:frame];
}
-(void)setValue:(NSString *)theValue{
	//NSLog(@"theValue: %@", theValue);
	@try{
	[self setText:[theValue stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	}
	@catch (id ex) {
		NSLog(@"ext: %@", ex);
	}
	self.hidden = NO;
}
-(void)drawTextInRect:(CGRect)rect{
	CGRect newRect = CGRectMake(rect.origin.x + padding, rect.origin.y + padding, rect.size.width - (padding * 2), rect.size.height - (padding * 2));
	[super drawTextInRect:newRect];
}
-(void)drawRect:(CGRect)rect{
	CGFloat lineWidth = 1;
	[super drawRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSetStrokeColorWithColor(ctx, [WSUtils UIColorFromHex:[[WSStyle instance] getTableLineHex]].CGColor);
	CGContextSetLineWidth(ctx, lineWidth);
	if([borders rangeOfString:@"T"].location != NSNotFound){
		CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x + rect.size.width, rect.origin.y);
		CGContextStrokePath(ctx);
	}
	if([borders rangeOfString:@"B"].location != NSNotFound){
		CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddLineToPoint(ctx, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
		CGContextStrokePath(ctx);
	}
	if([borders rangeOfString:@"L"].location != NSNotFound){
		CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextStrokePath(ctx);
	}
	if([borders rangeOfString:@"R"].location != NSNotFound){
		CGContextMoveToPoint(ctx, rect.origin.x + rect.size.width, rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
		CGContextStrokePath(ctx);
	}
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	NSLog(@"WSLabel touched");
}
-(void)dealloc{
	[super dealloc];
	[borders release];
}
@end
