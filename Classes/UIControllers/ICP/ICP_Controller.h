//
//  ICP_Controller.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 02/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTableViewController.h"
#import "WSTableView.h"
#import "WSXMLObject.h"
#import "WSSectionController.h"

@interface ICP_Controller : WSSectionController {
	//WSXMLObject *labelsData;
	//WSXMLObject *ratingsData;
	//NSMutableArray *labels;
	//NSMutableArray *ratings;
}
//@property(nonatomic, retain)WSXMLObject *labelsData;
//@property(nonatomic, retain)WSXMLObject *ratingsData;
//@property(nonatomic, retain)NSMutableArray *labels;
//@property(nonatomic, retain)NSMutableArray *ratings;

-(id)doInit:(WSTableView *)theTable ID:(NSString *)theID;
@end
