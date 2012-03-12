//
//  WSSectionController.h
//  BlueSheet
//
//  Created by Toby Widdowson on 14/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTableViewController.h"
#import "WSXMLObject.h"

@interface WSSectionController : UIViewController {
	WSTableViewController *tableViewController;
	WSXMLObject *data;
}
@property(nonatomic, retain)WSTableViewController *tableViewController;
@property(nonatomic, retain)WSXMLObject *data;

-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData notificationType:(NSString *)theNotificationType;
-(id)doInit:(WSTableView *)theTable data:(WSXMLObject *)theData;
-(id)doInit:(NSString *)theNotificationType;
-(id)initWithView:(UIView *)theView;
-(NSMutableArray *)BuildData;
@end
