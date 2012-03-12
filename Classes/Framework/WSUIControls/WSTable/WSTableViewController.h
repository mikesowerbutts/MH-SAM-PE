//
//  TableViewViewController.h
//  TableView
//
//  Created by Toby Widdowson on 27/04/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTableView.h"
#import "WSPopoverViewController.h"
#import "WSEditDialogController.h"
#import "WSTableViewCell.h"
#import "WSButtonController.h"
#import "WSButton.h"
#import "WSKVPairList.h"
#import "WSKVPair.h"

@class WSTableViewDataController;
@interface WSTableViewController : UITableViewController<UITableViewDelegate, UIScrollViewDelegate> {
	WSTableViewDataController *dataController;
	BOOL readOnly;
	BOOL multiSelect;
	WSKVPairList *selectedRowsData;
	UIViewController *delegate;
	NSMutableArray *colTypes;
	NSInteger cellPadding;
	BOOL selectable;
	NSString *mode;
	NSString *editMode;
	WSEditDialogController *editDialog;
	BOOL showAllRows;
	CGFloat numRows;
	NSString *tableTitle;
	NSInteger titleHeight;
	NSInteger headerHeight;
	NSMutableArray *colWidths;
	NSString *groupMode;
	WSButtonController *plusBtn_Controller;
	WSButton *plusBtn;
	WSButtonController *minusBtn_Controller;
	WSButton *minusBtn;
	BOOL showHeaders;
	BOOL rebuilding;
	UIView *headerContainerView;
	WSKVPairList *appletButtons;
}
@property (nonatomic, retain) UIView *headerContainerView;
@property (nonatomic, retain) WSTableViewDataController *dataController;
@property(nonatomic)CGFloat numRows;
@property(nonatomic) BOOL readOnly;
@property(nonatomic) BOOL showHeaders;
@property(nonatomic) BOOL showAllRows;
@property(nonatomic) BOOL multiSelect;
@property(nonatomic) BOOL selectable;

@property(nonatomic) BOOL rebuilding;

@property(nonatomic, retain)WSKVPairList *selectedRowsData;
@property(nonatomic, retain)UIViewController *delegate;
@property(nonatomic, retain)NSMutableArray *colTypes;
@property(nonatomic)NSInteger cellPadding;
@property(nonatomic, retain)NSString *mode;
@property(nonatomic, retain)NSString *editMode;
@property(nonatomic)NSInteger titleHeight;
@property(nonatomic)NSInteger headerHeight;
@property(nonatomic, retain)WSEditDialogController *editDialog;
@property(nonatomic, retain)NSString *tableTitle;
@property(nonatomic, retain)NSMutableArray *colWidths;
@property(nonatomic, retain)NSString *groupMode;
@property(nonatomic, retain)WSButton *plusBtn;
@property(nonatomic, retain)WSButton *minusBtn;
@property(nonatomic, retain)WSButtonController *plusBtn_Controller;
@property(nonatomic, retain)WSButtonController *minusBtn_Controller;
@property(nonatomic, retain)WSKVPairList *appletButtons;

-(id)init:(WSTableViewDataController *)theData readOnly:(BOOL)ro multiSelect:(BOOL)ms selectedRowsData:(WSKVPairList *)selRowsData;
-(id)initWithColsAndTable:(WSTableViewDataController *)theData readOnly:(BOOL)ro multiSelect:(BOOL)ms selectedRowsData:(WSKVPairList *)selRowsData table:(WSTableView *) theTable columnTypes:(NSMutableArray *)theColTypes tableTitle:(NSString *) theTableTitle groupMode:(NSString*)theGroupMode showColHeaders:(BOOL)showColumnHeaders;
-(id)initWithCols:(WSTableViewDataController *)theDataController readOnly:(BOOL)ro multiSelect:(BOOL)ms selectedRowsData:(WSKVPairList *)selRowsData tableFrame:(CGRect)tableFrame columnTypes:(NSMutableArray *)theColTypes tableTitle:(NSString *) theTableTitle groupMode:(NSString*)theGroupMode showColHeaders:(BOOL)showColumnHeaders;
-(CGRect)autosize;
//-(void)selectCells;
-(void)showEditDialog:(NSString *)ID srcRect:(CGRect)theSrcRect;
-(void)addEmptyRow;
-(void)setupVars;
-(void)buildHeader;
-(void)rebuildTable;
-(void)deleteSelectedRow:(NSString *)theMode;
-(void)addRecord;
-(void)setTableViewFrame:(CGRect)newFrame;
-(void)removeAllViews;
@end

