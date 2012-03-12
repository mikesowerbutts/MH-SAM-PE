//
//  BSBestInfo.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSAction.h"

@interface BSBestInfo : WSAction {
	NSString *sourceDescription;
}
@property(nonatomic, retain)NSString *sourceDescription;
-(void)initVarsSub;
-(id)initWithBSBestInfo:(BSBestInfo *)obj;
@end
