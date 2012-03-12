//
//  WSButton.h
//  BlueSheet
//
//  Created by Toby Widdowson on 06/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLabel.h"
#import "WSButtonHighlight.h"
#import "WSKVPair.h"
@interface WSButton : UIControl {
	WSLabel *label;
	UIImageView *imageView;
	UIImage *image;
	NSString *imageFile;
	WSButtonHighlight *highlight;
	BOOL inited;
	UIViewController *delegate;
}
@property(nonatomic, retain)WSLabel *label;
@property(nonatomic, retain)NSString *imageFile;
@property(nonatomic)BOOL inited;
@property(nonatomic, retain)UIImage *image;
@property(nonatomic, retain)UIImageView *imageView;
@property(nonatomic, retain)WSButtonHighlight *highlight;
@property(nonatomic, retain)UIViewController *delegate;

-(id)initNormal;
-(id)initWithFrameAndImageFile:(CGRect)theFrame imageFile:(NSString *)imageFile;
-(void)build:(CGRect)frame;
-(void)buildImageView;
-(void)buildLabel;
-(void)buildHighlight;
-(void)setButtonFrame:(CGRect)newFrame;
-(void)additionalSetup;
-(void)triggerTouchWithNotification:(NSSet *)touches withEvent:(UIEvent *)event notification:(NSString *)notification;
@end
