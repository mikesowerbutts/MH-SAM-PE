//
//  WSMenuButtonController.h
//  CRMSync
//
//  Created by Toby Widdowson on 23/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSButtonController.h"
#import "WSEditDialogController.h"

@interface WSMenuButtonController : WSButtonController {
	WSEditDialogController *editDialog_Controller;
}
@property(nonatomic, retain)WSEditDialogController *editDialog_Controller;
@end
