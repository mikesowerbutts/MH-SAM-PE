//
//  MHTableBooleanLabel.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/10/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MHTableLabel.h"

@interface MHTableBooleanLabel : MHTableLabel {
    NSString *trueValue;
	NSString *falseValue;
}
@property(nonatomic, retain)NSString *trueValue;
@property(nonatomic, retain)NSString *falseValue;
@end
