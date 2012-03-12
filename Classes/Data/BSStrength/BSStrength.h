//
//  BSStrength.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"

@interface BSStrength : WSDataObject {
	NSString *description;
}
@property(nonatomic, retain)NSString *description;
-(void)initVarsSub;
-(id)copyObject;
@end
