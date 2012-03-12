//
//  WSTableViewGroupController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 27/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTableViewController.h"
#import "WSTableView.h"

@interface WSTableViewGroupController : NSObject {
	NSMutableArray *tableViews;
}
@property(nonatomic, retain)NSMutableArray *tableViews;
-(id)initWithTableViews:(NSMutableArray *)theTableViews;
@end
