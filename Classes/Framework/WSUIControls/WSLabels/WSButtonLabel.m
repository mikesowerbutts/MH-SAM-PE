//
//  WSAppletButtonLabel.m
//  CRMSync
//
//  Created by Toby Widdowson on 07/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSButtonLabel.h"


@implementation WSButtonLabel
@synthesize button, button_Controller;
-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	borders = [[NSString alloc] initWithString:@""];
	self.button = [[WSButton alloc] initWithFrameAndImageFile:CGRectMake((self.frame.size.width / 2) - 10, (self.frame.size.height / 2) - 11, 20, 20) imageFile:@""];
	self.button_Controller = [[WSButtonController alloc] initWithButton:button];
	[self addSubview:button];
	return self;
}
-(void)setValue:(NSString *)theValue{
	@try{
		self.button.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", theValue]];
	}
	@catch (id ex) {
		NSLog(@"ext: %@", ex);
	}
	self.hidden = NO;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[button triggerTouchWithNotification:touches withEvent:event notification:@""];
}
@end
