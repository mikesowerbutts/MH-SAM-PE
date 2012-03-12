//
//  WSUITextView.m
//  BlueSheet
//
//  Created by Toby Widdowson on 13/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSUITextView.h"


@implementation WSUITextView
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.delegate setActiveControl:self];
}
@end
