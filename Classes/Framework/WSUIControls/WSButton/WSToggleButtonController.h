//
//  WSToggleButton.h
//  BlueSheet
//
//  Created by Toby Widdowson on 21/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSButtonController.h"
#import "WSToggleButton.h"

@interface WSToggleButtonController : WSButtonController {
	int state;
	NSMutableArray *stateImages;
	NSString *trueValue;
}
@property(nonatomic)int state;
@property(nonatomic, retain)NSMutableArray *stateImages;
@property(nonatomic, retain)NSString *trueValue;

-(void)touchUpInside;
-(void)setupState:(int)newState;
-(void)setChecked:(NSString *)value;
-(NSString *)getStringValue;
@end
