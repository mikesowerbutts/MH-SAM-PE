//
//  WSCheckLabel.m
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSBooleanCheckLabel.h"


@implementation WSBooleanCheckLabel
-(id)initWithFrame:(CGRect)frame{	
	trueValue = @"✓";
	falseValue = @"";
	[super initWithFrame:frame];
	self.font = [UIFont fontWithName:@"ZapfDingbatsITC" size:16];
	return self;
}
@end
