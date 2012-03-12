//
//  WSLabel.h
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSLabel : UILabel {
	CGFloat padding;
	NSString *borders;
}
@property(nonatomic)CGFloat padding;
@property(nonatomic, retain)NSString *borders;
-(void)setValue:(NSString *)theValue;
@end
