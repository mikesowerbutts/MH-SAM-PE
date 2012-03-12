//
//  WSColumnInfo.h
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSColumnInfo : NSObject {
	NSString *colType;
	CGFloat colWidth;
	NSString *colHeader;
	UITextAlignment colHeaderAlignment;
}
@property(nonatomic, retain)NSString *colType;
@property(nonatomic)CGFloat colWidth;
@property(nonatomic, retain)NSString *colHeader;
@property(nonatomic)UITextAlignment colHeaderAlignment;
-(id)initID;
-(id)init:(NSString *)theColType columnWidth:(CGFloat)theColWidth columnHeader:(NSString *)theColHeader;
-(id)initWithAlignment:(NSString *)theColType columnWidth:(CGFloat)theColWidth columnHeader:(NSString *)theColHeader columnTextAlign:(UITextAlignment)theTextAlignment;
@end
