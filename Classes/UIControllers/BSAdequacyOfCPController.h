//
//  BSAdequacyOfCPController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 16/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSSliderController.h"
#import "MHFlagButtonController.h"

@interface BSAdequacyOfCPController : WSSliderController {
    MHFlagButtonController *flagController;
    NSString *flagID;
    BOOL addedListeners;
}
@property(nonatomic)BOOL addedListeners;
@property(nonatomic, retain)NSString *flagID;
@property(nonatomic, retain)MHFlagButtonController *flagController;
-(void)checkFlag:(NSString *)theFlagID;
@end
