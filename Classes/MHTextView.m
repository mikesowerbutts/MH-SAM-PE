//
//  MHTextView.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHTextView.h"
#import "BSDragObject.h"
#import "BlueSheetDataModel.h"
#import "WSFieldController.h"

@implementation MHTextView
@synthesize flagID, flagController, addedListeners;
-(void)checkFlag:(NSString *)theFlagID{
    if(!addedListeners){
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDragged:) name:@"MHFlagDragging" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDropped:) name:@"MHFlagDropped" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDestroyed:) name:@"MHFlagDestroyed" object:nil];
        addedListeners = YES;
    }
	self.flagID = theFlagID;
    WSFieldController *fc = (WSFieldController *)self.delegate;
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:fc.ID];
    if(dm != nil){
        BSDragObject *d = (BSDragObject *)[dm.flagsList getObjectByID:self.flagID];
        if(d != nil){
            CGPoint center = CGPointMake(self.textView.frame.size.width * [d.xRatio floatValue], self.textView.frame.size.height * [d.yRatio floatValue]);
            UIImage *img = [UIImage imageNamed:[d getImage]];
            if(center.x < 0)
                center.x = img.size.width;
            if(center.y < 0)
                center.y = img.size.height;
            WSDraggableButton *flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
            flagBtn.imageView.image = img;
            flagBtn.highlight.hidden = YES;
            flagBtn.center = center;
            self.flagController = [[[MHFlagButtonController alloc] initWithButtonViewAndRect:flagBtn containerView:self.superview dragRect:CGRectMake(0, 0, 1024, 768) ID:[self.delegate ID]] autorelease];
            flagController.dragObj = d;
            flagController.owner = self;
            self.flagController.type = d.type;
            flagController.hideWhenCopying = YES;
            [self addSubview:self.flagController.dragBtn];
            [self bringSubviewToFront:self.flagController.dragBtn];
        }
    }
    else
        NSLog(@"DataModel was null in MHTextView");
}

-(void)flagDropped:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if(dbc.owner == self){
		CGPoint pt = [self convertPoint:dbc.theCopy.center fromView:dbc.containerView];
        if(pt.x < 0)
            pt.x = dbc.theCopy.image.size.width / 2;
        if(pt.y < 0)
            pt.y = dbc.theCopy.image.size.height / 2;
		pt = CGPointMake(pt.x, self.frame.size.height / 2);
		[dbc.theCopy removeFromSuperview];
		dbc.theCopy = nil;
		self.flagController = [[dbc copy] autorelease];
		self.flagController.hideWhenCopying = YES;
		CGPoint perPt = [WSUtils PointPercentageInRect:self.textView.frame point:pt];
		BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:self.flagController.ID];        
		if(self.flagController.dragObj == nil){
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
        }
		else{
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagController.dragObj.ID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
		}
        self.flagController.dragObj.ID = self.flagID;
		[dm.flagsList.items addObject:self.flagController.dragObj];
        [self checkFlag:self.flagID];
	}
	else if(dbc == self.flagController){
		[dbc.theCopy removeFromSuperview];
		self.flagController = nil;
		[self.flagController release];
	}
}

-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if([dbc.type isEqualToString:@"redflag"] || [dbc.type isEqualToString:@"barbell"]){
		CGRect fr = CGRectMake(dbc.theCopy.imageView.frame.origin.x + dbc.theCopy.frame.origin.x, dbc.theCopy.imageView.frame.origin.y + dbc.theCopy.frame.origin.y, dbc.theCopy.imageView.frame.size.width, dbc.theCopy.imageView.frame.size.height);
		CGRect inter = CGRectIntersection(self.frame, fr);
		//Dragged in
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6) &&
		   self.flagID != nil && (dbc.owner == nil || dbc.owner == self) && 
		   (self.flagController == nil || self.flagController == dbc)){
			dbc.magController.red.hidden = YES;
			dbc.owner = self;
		}
		//Dragged out
		else if(self.flagID != nil && dbc.owner == self){
			dbc.magController.red.hidden = NO;
			dbc.owner = nil;
		}
	}
	else if([dbc.type isEqualToString:@"eraser"] && self.flagController != nil){
		CGRect fr = dbc.theCopy.frame;
		CGRect cFr = [dbc.theCopy.superview convertRect:self.flagController.dragBtn.frame fromView:self];
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6)){
			BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[self.delegate ID]];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
			[self.flagController.dragBtn removeFromSuperview];
			self.flagController = nil;
            dbc.theCopy.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagErased" object:nil];
            dbc.theCopy.hidden = NO;
		}
	}
}

/*
-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if([dbc.type isEqualToString:@"redflag"] || [dbc.type isEqualToString:@"barbell"]){
		CGRect fr = CGRectMake(dbc.theCopy.imageView.frame.origin.x + dbc.theCopy.frame.origin.x, dbc.theCopy.imageView.frame.origin.y + dbc.theCopy.frame.origin.y, dbc.theCopy.imageView.frame.size.width, dbc.theCopy.imageView.frame.size.height);
		CGRect inter = CGRectIntersection(self.frame, fr);
		//Dragged in
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6) &&
		   self.flagID != nil && 
		   (dbc.owner == nil || dbc.owner == self) && 
		   (self.flagController == nil || self.flagController == dbc)){
			dbc.magController.red.hidden = YES;
			dbc.owner = self;
		}
		//Dragged out
		else if(dbc.owner == self){
			dbc.magController.red.hidden = NO;
			dbc.owner = nil;
		}
	}
	else if([dbc.type isEqualToString:@"eraser"] && self.flagController != nil){
		CGRect fr = dbc.theCopy.frame;
		CGRect cFr = [dbc.theCopy.superview convertRect:self.flagController.dragBtn.frame fromView:self];
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6)){
			BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[[self.delegate delegate] ID]];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
			[self.flagController.dragBtn removeFromSuperview];
			[self.flagController release];
			self.flagController = nil;
            dbc.theCopy.hidden = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MHFlagErased" object:nil];
            dbc.theCopy.hidden = NO;
		}
	}
}
*/
-(void)flagDestroyed:(NSNotification *)notification{
	if([notification object] == self.flagController)
		self.flagController = nil;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    [flagID release];
    [flagController release];
}
@end
