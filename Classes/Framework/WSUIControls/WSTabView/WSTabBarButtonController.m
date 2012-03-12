//
//  WSTabBarButtonController.m
//  CRMSync
//
//  Created by Toby Widdowson on 04/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSTabBarButtonController.h"
#import "WSStyle.h"
#import "WSUtils.h"

@implementation WSTabBarButtonController
-(void)toggleSelected{
	if(self.selected){
		button.highlight.highlightColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnHighlightHex]];
		[button.highlight setNeedsDisplay];
		button.imageView.image = [UIImage imageNamed:[button.imageFile stringByReplacingOccurrencesOfString:@"." withString:@"-grey."]];
		selected = NO;
	}
	else{
		button.highlight.highlightColor = [WSUtils UIColorFromHex:[[WSStyle instance] getBtnHighlightActiveHex]];
		[button.highlight setNeedsDisplay];
		button.imageView.image = button.image;
		selected = YES;
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
