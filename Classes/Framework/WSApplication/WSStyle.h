//
//  Style.h
//  BlueSheet
//
//  Created by Toby Widdowson on 01/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSStyle : NSObject {
	NSString *bGHex;
	NSString *secHeaderBGHex;
	NSString *secHeaderFontHex;
	NSString *colHeaderBGHex;
	NSString *colHeaderFontHex;
	NSString *tableLineHex;
	NSString *tableBGHex;
	NSString *normalFontHex;
	UIFont *normalFont;
	UIFont *secHeaderFont;
	UIFont *colHeaderFont;
	NSString *btnBGHex;
	NSString *btnHighlightActiveHex;
	NSString *btnFGHex;
	NSString *btnHighlightHex;
	NSString *btnBorderHex;
	NSString *tblHighlightHex;
}
@property(nonatomic, retain)NSString *bGHex;
@property(nonatomic, retain)NSString *secHeaderBGHex;
@property(nonatomic, retain)NSString *secHeaderFontHex;
@property(nonatomic, retain)NSString *colHeaderBGHex;
@property(nonatomic, retain)NSString *colHeaderFontHex;
@property(nonatomic, retain)NSString *tableLineHex;
@property(nonatomic, retain)NSString *tableBGHex;
@property(nonatomic, retain)NSString *normalFontHex;
@property(nonatomic, retain)NSString *btnBGHex;
@property(nonatomic, retain)NSString *btnHighlightHex;
@property(nonatomic, retain)NSString *btnHighlightActiveHex;
@property(nonatomic, retain)NSString *btnFGHex;
@property(nonatomic, retain)NSString *btnBorderHex;
@property(nonatomic, retain)NSString *tblHighlightHex;
@property(nonatomic, retain)UIFont *normalFont;
@property(nonatomic, retain)UIFont *secHeaderFont;
@property(nonatomic, retain)UIFont *colHeaderFont;
+ (WSStyle *)instance;
-(NSString *)getBGHex;
-(NSString *)getSecHeaderBGHex;
-(NSString *)getSecHeaderFontHex;
-(NSString *)getColHeaderBGHex;
-(NSString *)getColHeaderFontHex;
-(NSString *)getSecHeaderFontHex;
-(NSString *)getTableLineHex;
-(NSString *)getTableBGHex;
-(NSString *)getTblHighlightHex;
-(NSString *)getBtnBGHex;
-(NSString *)getBtnHighlightHex;
-(NSString *)getBtnHighlightActiveHex;
-(NSString *)getBtnFGHex;
-(NSString *)getBtnBorderHex;
-(UIFont *)getNormalFont;
-(UIFont *)getSecHeaderFont;
-(UIFont *)getColHeaderFont;
@end
