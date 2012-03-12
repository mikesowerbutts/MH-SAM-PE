//
//  WSAppletButtonLabel.m
//  MH SAM PE
//
//  Created by Toby Widdowson on 11/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSAppletButtonLabel.h"


@implementation WSAppletButtonLabel
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[button triggerTouchWithNotification:touches withEvent:event notification:@"AppletBtnTouched"];
}
@end
