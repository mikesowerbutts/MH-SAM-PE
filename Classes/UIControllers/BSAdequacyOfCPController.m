//
//  BSAdequacyOfCPController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 16/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "BSAdequacyOfCPController.h"
#import "BSDragObject.h"
#import "BlueSheetDataModel.h"


@implementation BSAdequacyOfCPController
@synthesize flagController, flagID, addedListeners;
-(id)initWithSliderAndSliderLoc:(WSSlider *)theSlider sliderLoc:(WSKVPair *)theSliderLoc{
	[super initWithSliderAndSliderLoc:theSlider sliderLoc:theSliderLoc];
	NSMutableArray *labels = [[NSMutableArray alloc] init];
	[labels addObject:@"EUPHORIA"];
	[labels addObject:@"GREAT"];
	[labels addObject:@"SECURE"];
	[labels addObject:@"COMFORT"];
	[labels addObject:@"OK"];
	[labels addObject:@"CONCERN"];
	[labels addObject:@"DISCOMFORT"];
	[labels addObject:@"WORRY"];
	[labels addObject:@"FEAR"];
	[labels addObject:@"PANIC"];
	NSMutableArray *sliderImageFiles = [[NSMutableArray alloc] init];
	[sliderImageFiles addObject:@"ACP_blue.png"];
	[sliderImageFiles addObject:@"ACP_red.png"];
	NSMutableArray *trackImageFiles = [[NSMutableArray alloc] init];
	UIFont *labelFont = [UIFont systemFontOfSize:8];
	UIColor *normalLabelColor = [UIColor grayColor];
	UIColor *hotLabelColor = [UIColor blackColor];	
	[self.slider initWithLabelsImagesFontAndColors:labels sliderImageFiles:sliderImageFiles trackImages:trackImageFiles labelFont:labelFont normalLabelColor:normalLabelColor hotLabelColor:hotLabelColor];
	[self setSliderLabelFormat];
	[self setSliderPos];
    [labels release];//Leak
    [sliderImageFiles release];//Leak
    [trackImageFiles release];//Leak
	return self;
}
-(void)setSliderLabelFormat{
	for(int i = 0; i < [self.slider.labels count]; i++){
		WSLabel *lbl = [self.slider.labels objectAtIndex:i];
		if(i != [self.sliderLoc.key intValue])
			lbl.textColor = self.slider.normalLabelColor;
		else 
			lbl.textColor = self.slider.hotLabelColor;
	}
	if([self.sliderLoc.key intValue] != 0 && [self.sliderLoc.key intValue] != 9)
		self.slider.sliderBtn.imageView.image = [self.slider.sliderImages objectAtIndex:0];
	else
		self.slider.sliderBtn.imageView.image = [self.slider.sliderImages objectAtIndex:1];
}
-(void)sliderLocChanged{
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:[self.slider.delegate ID]];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ACPChanged" object:self.sliderLoc];
}
-(void)checkFlag:(NSString *)theFlagID{
    if(!addedListeners){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDragged:) name:@"MHFlagDragging" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDropped:) name:@"MHFlagDropped" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(flagDestroyed:) name:@"MHFlagDestroyed" object:nil];
        addedListeners = YES;
    }
	self.flagID = theFlagID;
	BlueSheetDataModel *dm = (BlueSheetDataModel *)[[WSDataModelManager instance] getByID:[self.slider.delegate ID]];
    if(dm != nil){
        BSDragObject *d = (BSDragObject *)[dm.flagsList getObjectByID:self.flagID];
        if(d != nil){
            CGPoint center = CGPointMake(self.slider.frame.size.width * [d.xRatio floatValue], self.slider.frame.size.height * [d.yRatio floatValue]);
            UIImage *img = [UIImage imageNamed:[d getImage]];
            if(center.x < 0)
                center.x = img.size.width / 2;
            if(center.y < 0)
                center.y = img.size.height / 2;
            WSDraggableButton *flagBtn = [[WSDraggableButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
            flagBtn.imageView.image = img;
            flagBtn.highlight.hidden = YES;
            flagBtn.center = center;
            self.flagController = [[MHFlagButtonController alloc] initWithButtonViewAndRect:flagBtn containerView:self.slider.superview dragRect:CGRectMake(0, 0, 1024, 768) ID:[self.slider.delegate ID]];
            flagController.dragObj = d;
            flagController.owner = self.slider;
            self.flagController.type = d.type;
            flagController.hideWhenCopying = YES;
            [self.slider addSubview:self.flagController.dragBtn];
            [self.slider bringSubviewToFront:self.flagController.dragBtn];
        }
    }
    else{
        NSLog(@"DataModel was null in MHTextField");
    }
}
-(void)flagDropped:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if(dbc.owner == self.slider){
		CGPoint pt = [self.slider convertPoint:dbc.theCopy.center fromView:dbc.containerView];
        if(pt.x < 0)
            pt.x = dbc.theCopy.image.size.width / 2;
        if(pt.y < 0)
            pt.x = dbc.theCopy.image.size.height / 2;
		pt = CGPointMake(pt.x, self.slider.frame.size.height / 2);
		[dbc.theCopy removeFromSuperview];
		dbc.theCopy = nil;
		self.flagController = [dbc copy];
		self.flagController.hideWhenCopying = YES;
		CGPoint perPt = [WSUtils PointPercentageInRect:self.slider.frame point:pt];
        BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[self.slider.delegate ID]];
		if(self.flagController.dragObj == nil)
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
		else{
			self.flagController.dragObj = [[BSDragObject alloc] initWithProps:self.flagController.dragObj.ID xRatio:[NSString stringWithFormat:@"%f", perPt.x] yRatio:[NSString stringWithFormat:@"%f", perPt.y] type:self.flagController.type];
			[dm.flagsList removeObjectByID:self.flagController.dragObj.ID];
		}
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
		CGRect inter = CGRectIntersection(self.slider.frame, fr);
		//Dragged in
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6) &&
		   self.flagID != nil && (dbc.owner == nil || dbc.owner == self.slider) && 
		   (self.flagController == nil || self.flagController == dbc)){
			dbc.magController.red.hidden = YES;
			dbc.owner = self.slider;
		}
		//Dragged out
		else if(self.flagID != nil && dbc.owner == self.slider){
			dbc.magController.red.hidden = NO;
			dbc.owner = nil;
		}
	}
	else if([dbc.type isEqualToString:@"eraser"] && self.flagController != nil){
		CGRect fr = dbc.theCopy.frame;
		CGRect cFr = [dbc.theCopy.superview convertRect:self.flagController.dragBtn.frame fromView:self.slider];
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6)){
			BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[self.slider.delegate ID]];
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

/*
-(void)flagDragged:(NSNotification *)notification{
	MHFlagButtonController *dbc = [notification object];
	if([dbc.type isEqualToString:@"redflag"] || [dbc.type isEqualToString:@"barbell"]){
		CGRect fr = CGRectMake(dbc.theCopy.imageView.frame.origin.x + dbc.theCopy.frame.origin.x, dbc.theCopy.imageView.frame.origin.y + dbc.theCopy.frame.origin.y, dbc.theCopy.imageView.frame.size.width, dbc.theCopy.imageView.frame.size.height);
		CGRect inter = CGRectIntersection(self.slider.frame, fr);
		//Dragged in
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6) &&
		   self.flagID != nil && 
		   (dbc.owner == nil || dbc.owner == self) && 
		   (self.flagController == nil || self.flagController == dbc)){
			dbc.magController.red.hidden = YES;
			dbc.owner = self.slider;
		}
		//Dragged out
		else if(self.flagID != nil && dbc.owner == self){
			dbc.magController.red.hidden = NO;
			dbc.owner = nil;
		}
	}
	else if([dbc.type isEqualToString:@"eraser"] && self.flagController != nil){
		CGRect fr = dbc.theCopy.frame;
		CGRect cFr = [dbc.theCopy.superview convertRect:self.flagController.dragBtn.frame fromView:self.slider];
		CGRect inter = CGRectIntersection(cFr, fr);
		if(inter.size.height > (fr.size.height * 0.6) && 
		   inter.size.width > (fr.size.width * 0.6)){
			BlueSheetDataModel *dm = [[WSDataModelManager instance] getByID:[self.slider.delegate ID]];
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
@end
