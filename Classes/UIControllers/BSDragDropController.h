//
//  BSDragDropController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 17/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDragDrop.h"

@interface BSDragDropController : UIViewController {
	BSDragDrop *dragDrop;
	UIView *mainView;
	MHFlagButtonController *currCopy;
}
@property(nonatomic, retain)MHFlagButtonController *currCopy;
@property(nonatomic, retain)BSDragDrop *dragDrop;
@property(nonatomic, retain)UIView *mainView;

-(id)initWithDragDrop:(BSDragDrop *)theDragDrop;
@end
