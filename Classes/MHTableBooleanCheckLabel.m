//
//  MHTableBooleanCheckLabel.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/10/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTableBooleanCheckLabel.h"


@implementation MHTableBooleanCheckLabel
-(id)initWithFrame:(CGRect)frame{	
	trueValue = @"✓";
	falseValue = @"";
	[super initWithFrame:frame];
	self.font = [UIFont fontWithName:@"ZapfDingbatsITC" size:16];
	return self;
}
@end
