//
//  DataController.h
//  TableView
//
//  Created by Toby Widdowson on 27/04/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDataObjectList.h"
#import "WSDataPicker.h"

@interface WSTableViewDataController : NSObject {
	NSMutableArray *list;
	WSDataPicker *dataPicker;
}
@property(nonatomic, retain)NSMutableArray *list;
@property(nonatomic, retain)WSDataPicker *dataPicker;

-(id)initWithPicker:(WSDataPicker *)theDataPicker;
-(unsigned)countOfList;
-(id)objectInListAtIndex:(unsigned)theIndex;
-(NSMutableArray *)getList;
@end
