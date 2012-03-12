//
//  WSAppletButtonLabel.h
//  CRMSync
//
//  Created by Toby Widdowson on 07/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLabel.h"
#import "WSButton.h"
#import "WSButtonController.h"

@interface WSButtonLabel : WSLabel {
	WSButton *button;
	WSButtonController *button_Controller;
}
@property(nonatomic, retain)WSButton *button;
@property(nonatomic, retain)WSButtonController *button_Controller;
@end
