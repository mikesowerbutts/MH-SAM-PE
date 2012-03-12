//
//  Style.m
//  BlueSheet
//
//  Created by Toby Widdowson on 01/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSStyle.h"
static WSStyle *myInstance = nil;

@implementation WSStyle

@synthesize bGHex;
@synthesize secHeaderBGHex;
@synthesize secHeaderFontHex;
@synthesize colHeaderBGHex;
@synthesize colHeaderFontHex;
@synthesize tableLineHex;
@synthesize tableBGHex;
@synthesize normalFontHex;
@synthesize normalFont;
@synthesize secHeaderFont;
@synthesize colHeaderFont;
@synthesize btnBGHex;
@synthesize btnFGHex;
@synthesize btnHighlightHex;
@synthesize btnHighlightActiveHex;
@synthesize btnBorderHex;
@synthesize tblHighlightHex;
+ (WSStyle *)instance{
	@synchronized(self){
		if(myInstance == nil){
			myInstance = [[WSStyle alloc] init];
			myInstance.bGHex = [[NSString alloc] initWithString:@"BFD1EE"];
			myInstance.secHeaderBGHex = [[NSString alloc] initWithString:@"336699"];
			myInstance.secHeaderFontHex = [[NSString alloc] initWithString:@"FFFFFF"];
			myInstance.colHeaderBGHex = [[NSString alloc] initWithString:@"BFD1EE"];
			myInstance.colHeaderFontHex = [[NSString alloc] initWithString:@"343434"];
			myInstance.tableLineHex = [[NSString alloc] initWithString:@"999999"];
			myInstance.tableBGHex = [[NSString alloc] initWithString:@"CBDAF1"];
			myInstance.normalFont = [UIFont fontWithName:@"ArialMT" size:UIFont.smallSystemFontSize];
			myInstance.secHeaderFont = [UIFont fontWithName:@"Arial-BoldMT" size:12.0];
			myInstance.colHeaderFont = [UIFont fontWithName:@"ArialMT" size:UIFont.smallSystemFontSize];
			myInstance.btnBGHex = [[NSString alloc] initWithString:@"5379AF"];
			myInstance.btnFGHex = [[NSString alloc] initWithString:@"FFFFFF"];
			myInstance.btnHighlightHex = [[NSString alloc] initWithString:@"FFFFFF"];
			myInstance.btnHighlightActiveHex = [[NSString alloc] initWithString:@"F5FF88"];
			myInstance.btnBorderHex = [[NSString alloc] initWithString:@"46699B"];
			myInstance.tblHighlightHex = [[NSString alloc] initWithString:@"A2AEC0"];
		}
	}
	return myInstance;
}
-(NSString *)getBGHex{
	return bGHex;
}
-(NSString *)getSecHeaderBGHex{
	return secHeaderBGHex;
}
-(NSString *)getSecHeaderFontHex{
	return secHeaderFontHex;
}
-(NSString *)getColHeaderBGHex{
	return colHeaderBGHex;
}
-(NSString *)getColHeaderFontHex{
	return colHeaderFontHex;
}
-(NSString *)getTableLineHex{
	return tableLineHex;
}
-(NSString *)getTableBGHex{
	return tableBGHex;
}
-(NSString *)getBtnBGHex{
	return btnBGHex;
}
-(NSString *)getBtnHighlightHex{
	return btnHighlightHex;
}
-(NSString *)getBtnHighlightActiveHex{
	return btnHighlightActiveHex;
}
-(NSString *)getBtnFGHex{
	return btnFGHex;
}
-(NSString *)getBtnBorderHex{
	return btnBorderHex;
}
-(NSString *)getTblHighlightHex{
	return tblHighlightHex;
}
-(UIFont *)getNormalFont{
	return normalFont;
}
-(UIFont *)getSecHeaderFont{
	return secHeaderFont;
}
-(UIFont *)getColHeaderFont{
	return colHeaderFont;
}

@end
