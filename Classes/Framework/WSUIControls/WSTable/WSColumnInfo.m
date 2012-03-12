//
//  WSColumnInfo.m
//  BlueSheet
//
//  Created by Toby Widdowson on 20/08/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSColumnInfo.h"


@implementation WSColumnInfo
@synthesize colType, colWidth, colHeader, colHeaderAlignment;
-(id)initID{
	colType = @"ID";
	colWidth = 0;
	colHeader = @"ID";
	colHeaderAlignment = UITextAlignmentCenter;
	return self;
}
-(id)init:(NSString *)theColType columnWidth:(CGFloat)theColWidth columnHeader:(NSString *)theColHeader{
	colType = theColType;
	colWidth = theColWidth;
	colHeader = theColHeader;
	colHeaderAlignment = UITextAlignmentLeft;
	return self;
}
-(id)initWithAlignment:(NSString *)theColType columnWidth:(CGFloat)theColWidth columnHeader:(NSString *)theColHeader columnTextAlign:(UITextAlignment)theTextAlignment{
	colType = theColType;
	colWidth = theColWidth;
	colHeader = theColHeader;
	colHeaderAlignment = theTextAlignment;
	return self;
}
@end
