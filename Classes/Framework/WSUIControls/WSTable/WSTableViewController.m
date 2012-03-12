//
//  TableViewAppDelegate.m
//  TableView
//
//  Created by Toby Widdowson on 27/04/2010.
//  Copyright White Springs Ltd 2010. All rights reserved.
//

#import "WSTableViewController.h"
#import "WSTableViewDataController.h"
#import "WSTableViewCell.h"
#import "WSLabel.h"
#import "WSColHeaderLabel.h"
#import "WSDateLabel.h"
#import "WSCurrencyLabel.h"
#import "WSNumberLabel.h"
#import "WSBooleanLabel.h"
#import "WSBooleanCheckLabel.h"
#import "WSColumnInfo.h"
#import "WSStyle.h"
#import "WSUtils.h"
#import "WSButtonController.h"
#import "WSButton.h"
#import <QuartzCore/QuartzCore.h>
#import "WSKVPairList.h"
#import "WSDataObjectList.h"
#import "WSListPickerController.h"
#import "WSAppletButtonLabel.h"

@implementation WSTableViewController
@synthesize dataController, selectedRowsData;
@synthesize readOnly, multiSelect, delegate, selectable, showAllRows, showHeaders, rebuilding;
@synthesize colTypes;
@synthesize cellPadding;
@synthesize mode, editMode;
@synthesize editDialog;
@synthesize numRows;
@synthesize tableTitle;
@synthesize titleHeight, headerHeight;
@synthesize colWidths, groupMode;
@synthesize plusBtn, minusBtn, plusBtn_Controller, minusBtn_Controller, headerContainerView, appletButtons;

-(id)init:(WSTableViewDataController *)theDataController readOnly:(BOOL)ro multiSelect:(BOOL)ms selectedRowsData:(WSKVPairList *)selRowsData
{
	dataController = theDataController;
	groupMode = @"NONE";
	colTypes = [[NSMutableArray alloc] init];
	[colTypes addObject:[[WSColumnInfo alloc] initWithAlignment:@"STRING" columnWidth:100 columnHeader:@" " columnTextAlign:UITextAlignmentLeft]];
	colWidths = [[NSMutableArray alloc] init];
	selectedRowsData = [selRowsData mutableCopy];
	readOnly = ro;
	multiSelect = ms;
	self.tableView = [[WSTableView alloc] initWithFrame:CGRectMake(0, 0, 300, 1) style:UITableViewStylePlain];	 
	[colWidths addObject:[NSNumber numberWithFloat:self.tableView.frame.size.width]];
	[self setupVars];
	return self;
}

-(id)initWithColsAndTable:(WSTableViewDataController *)theDataController readOnly:(BOOL)ro 
			  multiSelect:(BOOL)ms 
		      selectedRowsData:(WSKVPairList *)selRowsData 
			  table:(WSTableView *) theTable 
			  columnTypes:(NSMutableArray *)theColTypes 
			  tableTitle:(NSString *) theTableTitle 
			  groupMode:(NSString*)theGroupMode 
			  showColHeaders:(BOOL)showColumnHeaders
{	
	dataController = theDataController;
	groupMode = theGroupMode;
	tableTitle = theTableTitle;
	colTypes = theColTypes;
	selectedRowsData = selRowsData != nil ? [selRowsData mutableCopy] : [[WSKVPairList alloc] init];
	readOnly = ro;
	multiSelect = ms;
	self.tableView = theTable;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	showHeaders = showColumnHeaders;
	[self setupVars];
	[self buildHeader];
	return self;
}

-(id)initWithCols:(WSTableViewDataController *)theDataController readOnly:(BOOL)ro 
			  multiSelect:(BOOL)ms 
			  selectedRowsData:(WSKVPairList *)selRowsData
			  tableFrame:(CGRect)tableFrame
			  columnTypes:(NSMutableArray *)theColTypes 
			  tableTitle:(NSString *) theTableTitle 
			  groupMode:(NSString*)theGroupMode 
		      showColHeaders:(BOOL)showColumnHeaders
{	
	dataController = theDataController;
	groupMode = theGroupMode;
	tableTitle = theTableTitle;
	colTypes = theColTypes;
	selectedRowsData = selRowsData != nil ? [selRowsData mutableCopy] : [[WSKVPairList alloc] init];
	readOnly = ro;
	multiSelect = ms;
	self.tableView = [[WSTableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];	 
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	showHeaders = showColumnHeaders;
	[self setupVars];
	[self buildHeader];
	return self;
}

-(void)removeAllViews{
	[self.view removeFromSuperview];
	[self.tableView removeFromSuperview];
	[self.headerContainerView removeFromSuperview];
}

-(void)setTableViewFrame:(CGRect)newFrame{
	self.tableView.frame = newFrame;
	[self buildHeader];
	[self rebuildTable];
}

-(void)buildHeader{
	colWidths = [[NSMutableArray alloc] init];
	CGFloat prevWidth = 0;
	[self.headerContainerView removeFromSuperview];
	self.headerContainerView = [[[UIView alloc] initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.bounds.size.width, titleHeight + headerHeight)] autorelease];
	if(showHeaders){
		headerContainerView.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getColHeaderBGHex]];
		WSLabel *tableTitleLabel = [[[WSLabel alloc] initWithFrame:CGRectMake(0,0, self.tableView.bounds.size.width, titleHeight)] autorelease];
		tableTitleLabel.borders = @"LTR";
		tableTitleLabel.textAlignment = UITextAlignmentCenter;
		[tableTitleLabel setText:tableTitle];
		tableTitleLabel.font = [[WSStyle instance] getSecHeaderFont];
		tableTitleLabel.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderFontHex]];
		tableTitleLabel.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getSecHeaderBGHex]];
		tableTitleLabel.frame = CGRectMake(tableTitleLabel.frame.origin.x, tableTitleLabel.frame.origin.y, headerContainerView.bounds.size.width, titleHeight);
		[headerContainerView addSubview:tableTitleLabel];
		if(([groupMode isEqualToString:@"MASTER"] || [groupMode isEqualToString:@"NONE"]) && !readOnly){
			plusBtn = [[[WSButton alloc] initWithFrame:CGRectMake(2, 2, 20, 20)] autorelease];
			[plusBtn.label setValue:@"+"];
			[headerContainerView addSubview:plusBtn];
			plusBtn_Controller = [[WSButtonController alloc] initWithButton:plusBtn];
			minusBtn = [[[WSButton alloc] initWithFrame:CGRectMake(24, 2, 20, 20)] autorelease];
			[minusBtn.label setValue:@"-"];
			[headerContainerView addSubview:minusBtn];
			minusBtn_Controller = [[WSButtonController alloc] initWithButton:minusBtn];
		}
	}
	for(int i = 0; i < [colTypes count]; i++){
		WSColumnInfo *ci = [colTypes objectAtIndex:i];
		CGRect colFrame = CGRectMake(prevWidth, titleHeight, floor(((self.tableView.frame.size.width / 100) * ci.colWidth)), headerHeight);
		if(i == [colTypes count] -1 && (colFrame.size.width + prevWidth) < headerContainerView.frame.size.width){
			colFrame.size.width += (headerContainerView.frame.size.width - (colFrame.size.width + prevWidth));
		}
		[colWidths addObject:[NSNumber numberWithFloat:colFrame.size.width]];
		if(showHeaders){
			prevWidth += colFrame.size.width;
			WSColHeaderLabel *headerLabel = [[[WSColHeaderLabel alloc] initWithFrame:colFrame] autorelease];
			headerLabel.padding = cellPadding;
			headerLabel.textAlignment = ci.colHeaderAlignment;
			headerLabel.font = [[WSStyle instance] getColHeaderFont];
			headerLabel.textColor = [WSUtils UIColorFromHex:[[WSStyle instance] getColHeaderFontHex]];
			headerLabel.borders = @"TLB";
			if(i == [colTypes count] -1){headerLabel.borders = @"TLRB";}
			headerLabel.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getColHeaderBGHex]];
			headerLabel.frame = CGRectMake(headerLabel.frame.origin.x, headerLabel.frame.origin.y, colFrame.size.width, colFrame.size.height);
			[headerLabel setText:ci.colHeader];
			[headerContainerView addSubview:headerLabel];
		}
	}
	if(showHeaders){
		self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y + headerContainerView.frame.size.height, headerContainerView.frame.size.width, self.tableView.frame.size.height - headerContainerView.frame.size.height);
		[self.delegate.view addSubview:headerContainerView];
	}
}

-(void)setupVars{
	titleHeight = 24;
	headerHeight = 20;
	cellPadding = 5;
	selectable = YES;	
	self.tableView.editing = NO;
	self.tableView.dataSource = self;
	self.delegate = self.tableView.delegate;
	self.tableView.delegate = self;
	self.tableView.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getTableBGHex]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnTouchedUpInside:) name:@"btnTouchUpInside" object:nil];
}

-(void)btnTouchedUpInside:(NSNotification *)notification{
	WSButtonController *sbtn = (WSButtonController *)[notification object];
	if(sbtn == plusBtn_Controller){		
		[self addRecord];
	}
	else if(sbtn == minusBtn_Controller){
		[self deleteSelectedRow:@"NORMAL"];
	}
	else{
		for(int i = 0; i < [appletButtons.items count]; i++){
			if(sbtn == [appletButtons.items objectAtIndex:i]){
				[[NSNotificationCenter defaultCenter] postNotificationName:@"appletButtonTouched" object:[appletButtons.items objectAtIndex:i]];
			}
		}
	}
}

-(void)addRecord{
	[self showEditDialog:nil srcRect:plusBtn.frame];
}

-(void)deleteRow:(NSString *)ID mode:(NSString *)theMode{
	if(ID != nil){
		[self.dataController.dataPicker removeObjectByID:ID];
		if(![theMode isEqualToString:@"GROUP"]){
			[[NSNotificationCenter defaultCenter] postNotificationName:@"tableDeleteRow" object:self];
		}
		[self rebuildTable];
	}
}

-(void)deleteSelectedRow:(NSString *)theMode{
	WSTableViewCell *cell = (WSTableViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
	cell.accessoryType = UITableViewCellAccessoryNone;
	[self deleteRow:cell.ID mode:theMode];
}

-(void)addEmptyRow{
	for(int i = 0; i < [colTypes count]; i++){
		[dataController.list addObject:@""];
	}
	[self.tableView reloadData];
}

-(void)rebuildTable{
	rebuilding = YES;
	[self.dataController getList];
	[self.tableView reloadData];
}

-(CGRect)autosize{
	NSInteger itemCount = [dataController countOfList] / 2;
	NSInteger hei = 25 * itemCount;
	[self.tableView setFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, hei)];
	return CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);	 
}

-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	CGFloat height = 25;
	if(showAllRows){
		@try{
			CGFloat tblHei = theTableView.frame.size.height;
			height = tblHei / numRows;
		}
		@catch (id ex) {
			NSLog(@"error: %@", ex);
		}
	}
	return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	WSTableViewCell *cell = (WSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	if(selectable){
		BOOL found = NO;
		if([selectedRowsData getPairByKey:cell.ID] != nil){found = YES;}
		if(!multiSelect && found){
			cell.accessoryType = UITableViewCellAccessoryNone;
			[selectedRowsData removePairByKey:cell.ID];
		}
		else if(found){
			[selectedRowsData removePairByKey:cell.ID];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
		else{
			WSLabel *lbl = (WSLabel*)[cell.contentView.subviews objectAtIndex:0];
			[selectedRowsData.items addObject:[[WSKVPair alloc] initWithKeyValue:cell.ID aValue:lbl.text]];
			if(editMode == @"DIALOG"){
				cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;	
			}
			else{
				cell.accessoryType = UITableViewCellAccessoryCheckmark;
			}
		}
		if([mode isEqualToString:@"LIST"]){
			WSListPickerController *lpC = (WSListPickerController *)self.delegate;
			[lpC updateTextBox:selectedRowsData];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:@"tableRowSelected" object:self];
	}
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
	WSTableViewCell *cell = (WSTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
	if(cell.accessoryType == UITableViewCellAccessoryDetailDisclosureButton){
		[self showEditDialog:cell.ID srcRect:cell.frame];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}

-(void)showEditDialog:(NSString *)ID srcRect:(CGRect)theSrcRect{	
	[editDialog setupDialog:ID];
	[editDialog showPopoverFromRect:CGRectMake(self.tableView.frame.origin.x + theSrcRect.origin.x, self.tableView.frame.origin.y + theSrcRect.origin.y, theSrcRect.size.width, theSrcRect.size.height)];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	WSTableViewCell *cell = (WSTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	if(!multiSelect)
	{
		[selectedRowsData removePairByKey:cell.ID];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	if([mode isEqualToString:@"LIST"]){[delegate updateTextBox:selectedRowsData];}
}

-(void)doDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;	
	
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSInteger dataCnt = [dataController countOfList];
	NSInteger count = dataCnt / [colTypes count];
	if(count > 0){numRows = count;}
	return count;
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *ident = [NSString stringWithFormat:@"ident%i", indexPath.row];
	WSTableViewCell *cell = (WSTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:ident];
	if(cell == nil || rebuilding){
		if(cell == nil){
			cell = [[[WSTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:ident] autorelease];
		}
		[cell removeSubViews];
		UIView *selBG = [[[UIView alloc] init] autorelease];
		selBG.backgroundColor = [WSUtils UIColorFromHex:[[WSStyle instance] getTblHighlightHex]];
		cell.selectedBackgroundView = selBG;
		CGFloat prevWid = 0;
		NSInteger datPos = [colWidths count] * (indexPath.row);
		CGRect colRect = CGRectZero;
		for(int i = 0; i < [colTypes count]; i++){
			WSColumnInfo *ci = [colTypes objectAtIndex:i];
			if([ci.colType isEqualToString:@"ID"]){
				cell.ID = [dataController objectInListAtIndex:datPos];
			}
			else{
				colRect = CGRectZero;
				if(showAllRows){
					CGFloat tblHei = theTableView.frame.size.height - theTableView.tableHeaderView.frame.size.height;
					CGFloat rowHei = tblHei / numRows < 1000 ? tblHei / numRows : 25;
					colRect = CGRectMake(prevWid, theTableView.tableHeaderView.frame.size.height, [[colWidths objectAtIndex:i] floatValue], rowHei);
					theTableView.rowHeight = colRect.size.height;
				}
				else{
					colRect = CGRectMake(prevWid, theTableView.tableHeaderView.frame.size.height, [[colWidths objectAtIndex:i] floatValue], 25);
				}
				prevWid += [[colWidths objectAtIndex:i] floatValue];
				WSLabel *cellLabel = nil;
				if ([[ci colType] isEqualToString:@"NUMBER"]) {
					cellLabel = [[WSNumberLabel alloc] initWithFrame:colRect];
				}
				else if ([[ci colType] isEqualToString:@"CURRENCY"]) {
					cellLabel = [[WSCurrencyLabel alloc] initWithFrame:colRect];
				}
				else if ([[ci colType] isEqualToString:@"DATE"]) {
					cellLabel = [[WSDateLabel alloc] initWithFrame:colRect];
				}
				else if ([[ci colType] isEqualToString:@"BOOLEAN"]) {
					cellLabel = [[WSBooleanLabel alloc] initWithFrame:colRect];
				}
				else if ([[ci colType] isEqualToString:@"BOOLEANCHECK"]) {
					cellLabel = [[WSBooleanCheckLabel alloc] initWithFrame:colRect];
				}
				else if ([[ci colType] isEqualToString:@"APPLETBUTTON"]) {
					cellLabel = [[WSAppletButtonLabel alloc] initWithFrame:colRect];
					WSAppletButtonLabel *btnLbl = (WSAppletButtonLabel *)cellLabel;
					btnLbl.button_Controller.tag = cell.ID;
				}
				else{
					cellLabel = [[WSLabel alloc] initWithFrame:colRect];
				}
				cellLabel.tag = i;
				if([dataController countOfList] > datPos){
					[cellLabel setValue:[dataController objectInListAtIndex:datPos]];
				}
				else{
					[cellLabel setValue:@""];
				}
				cellLabel.textAlignment = ci.colHeaderAlignment;
				cellLabel.padding = cellPadding;
				cellLabel.borders = @"LB";
				cellLabel.font = [[WSStyle instance] getNormalFont];
				cellLabel.backgroundColor = [UIColor clearColor];
				if(i == [colTypes count] - 1){cellLabel.borders = @"LBR";}
				if(!selectable){cell.selectionStyle = UITableViewCellSelectionStyleNone;}
				[cell.contentView addSubview:cellLabel];
			}
			datPos++;
			if([selectedRowsData getPairByKey:cell.ID] != nil){
				//NSLog(@"selecting row");
				//cell.accessoryType = UITableViewCellAccessoryCheckmark;
				//[theTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
			}
		}
		cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, colRect.size.height);
	}
	return cell;
}
 
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger ret = 0;
	if(!readOnly)
	{
		if(indexPath.row == 0)
		{
			ret = 2; //insert symbol
		}
		else
		{
			ret = 1; //delete symbol
		}
	}
	else
	{
		ret = -1;
	}
	return ret;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"tableScroll" object:self];
}

-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}

-(void)dealloc {
	[super dealloc];
	[dataController release];
	[selectedRowsData release];
	[delegate release];
	[colWidths release];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
