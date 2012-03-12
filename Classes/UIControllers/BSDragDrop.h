//
//  BSDragDrop.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 17/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDraggableButton.h"
#import "MHFlagButtonController.h"
@interface BSDragDrop : UIControl {
	WSDraggableButton *barbell_Btn;
	MHFlagButtonController *barbell_Controller;
	WSDraggableButton *flag_Btn;
	MHFlagButtonController *flag_Controller;
	WSDraggableButton *eraser_Btn;
	MHFlagButtonController *eraser_Controller;
	IBOutlet UIViewController *delegate;
}
@property(nonatomic, assign)IBOutlet UIViewController *delegate;
@property(nonatomic, retain)WSDraggableButton *barbell_Btn;
@property(nonatomic, retain)MHFlagButtonController *barbell_Controller;
@property(nonatomic, retain)WSDraggableButton *flag_Btn;
@property(nonatomic, retain)MHFlagButtonController *flag_Controller;
@property(nonatomic, retain)WSDraggableButton *eraser_Btn;
@property(nonatomic, retain)MHFlagButtonController *eraser_Controller;
@end
