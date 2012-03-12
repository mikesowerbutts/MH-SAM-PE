//
//  BestActionPlan_TableViewController.m
//  MH SAM PE
//
//  Created by Toby Widdowson on 27/10/2011.
//  Copyright (c) 2011 White Springs Ltd. All rights reserved.
//

#import "BestActionPlan_TableViewController.h"
#import "MHTableLabel.h"
@implementation BestActionPlan_TableViewController
-(WSLabel *)setupLabel:(CGFloat)prevWid tableView:(UITableView *)theTableView colIdx:(int)colIdx rowIdx:(int)rowIdx colRect:(CGRect)colRect cell:(WSTableViewCell *)cell ci:(WSColumnInfo *)ci{
	WSLabel *cellLabel = [[MHTableLabel alloc] initWithFrame:colRect];
	return cellLabel;
}
@end
