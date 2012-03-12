//
//  WSDataPicker.h
//  BlueSheet
//
//  Created by Toby Widdowson on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"
#import "WSDataObjectList.h"

@interface WSDataPicker : NSObject {
	NSMutableArray *objList;
}
@property(nonatomic, retain)NSMutableArray *objList;
-(id)initWithList:(NSMutableArray *)theList;
-(NSMutableArray *)getData;
-(void)removeObjectByID:(NSString *)idToRemove;
@end
