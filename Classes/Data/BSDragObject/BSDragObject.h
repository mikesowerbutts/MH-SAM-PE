//
//  BSDragObject.h
//  BlueSheet
//
//  Created by Mike Sowerbutts on 08/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDataObject.h"

@interface BSDragObject : WSDataObject {
	NSString *xRatio;
	NSString *yRatio;
	NSString *type;
}
@property(nonatomic, retain)NSString *xRatio;
@property(nonatomic, retain)NSString *yRatio;
@property(nonatomic, retain)NSString *type;
-(NSString *)getImage;
-(void)initVarsSub;
-(id)initWithProps:(NSString *)theID xRatio:(NSString *)theXRatio yRatio:(NSString *)theYRatio type:(NSString *)theType;
@end
