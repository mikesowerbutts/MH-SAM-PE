//
//  WSTableViewCell.h
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSTableViewCell : UITableViewCell {
	NSMutableArray *columns;
	NSString *ID;
}
@property(nonatomic, retain)NSString *ID;

-(void)removeSubViews;
@end
