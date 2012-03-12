//
//  WSButtonHighlight.h
//  CRMSync
//
//  Created by Toby Widdowson on 04/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//



@interface WSButtonHighlight : UILabel {
	UIColor *highlightColor;
}

@property(nonatomic, retain)UIColor *highlightColor;
-(CGGradientRef)createGradient;
-(void)reDraw;

@end
