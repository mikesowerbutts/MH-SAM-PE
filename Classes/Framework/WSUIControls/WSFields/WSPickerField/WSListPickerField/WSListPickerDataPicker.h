//
//  WSListPickerDataPicker.h
//  BlueSheet
//
//  Created by Toby Widdowson on 15/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataPicker.h"
#import "WSKVPairList.h"

@interface WSListPickerDataPicker : WSDataPicker {
	WSKVPairList *kvPairList;
}
@property(nonatomic, retain)WSKVPairList *kvPairList;
-(id)initWithKVPairList:(WSKVPairList *)theList;
@end
