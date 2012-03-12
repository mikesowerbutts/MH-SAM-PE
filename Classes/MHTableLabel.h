//
//  MHTableLabel.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 28/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLabel.h"
#import "WSDraggableButton.h"
#import "MHFlagButtonController.h"

@interface MHTableLabel : WSLabel {
	NSString *flagID;
	MHFlagButtonController *flagController;
	NSString *dmID;
	BOOL isDragging;
    BOOL addedListeners;
}
@property(nonatomic)BOOL addedListeners;
@property(nonatomic, retain)NSString *flagID;
@property(nonatomic)BOOL isDragging;
@property(nonatomic, retain)NSString *dmID;
@property(nonatomic, retain)MHFlagButtonController *flagController;

-(void)checkFlag:(NSString *)theFlagID DataModelID:(NSString *)dmID;
@end
