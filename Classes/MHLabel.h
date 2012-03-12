//
//  MHLabel.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLabel.h"
#import "WSDraggableButton.h"
#import "WSDraggableButtonController.h"

@interface MHLabel : WSLabel {
	WSDraggableButtonController *flagController;
	WSDraggableButton *flagBtn;
}
@property(nonatomic, retain)WSDraggableButtonController *flagController;
@property(nonatomic, retain)WSDraggableButton *flagBtn;
@end
