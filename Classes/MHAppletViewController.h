//
//  MHAppletViewController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 23/05/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSAppViewController.h"
#import "WSButtonController.h"
#import "WSButton.h"

@interface MHAppletViewController : WSAppViewController {
    IBOutlet WSButton *saveBtn;
	IBOutlet WSButton *exitBtn;
}
@property(nonatomic, retain)IBOutlet WSButton *saveBtn;
@property(nonatomic, retain)IBOutlet WSButton *exitBtn;
@end
