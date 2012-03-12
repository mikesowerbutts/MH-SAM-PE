//
//  WSBooleanLabel.h
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLabel.h"

@interface WSBooleanLabel : WSLabel {
	NSString *trueValue;
	NSString *falseValue;
}
@property(nonatomic, retain)NSString *trueValue;
@property(nonatomic, retain)NSString *falseValue;
@end
