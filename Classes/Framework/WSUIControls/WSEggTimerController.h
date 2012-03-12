//
//  WSEddTimerController.h
//  CRMSync
//
//  Created by Toby Widdowson on 30/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSEggTimerController : UIViewController {
	IBOutlet UILabel *message;
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic, retain)UILabel *message;
@property(nonatomic, retain)UIActivityIndicatorView *activityIndicator;

-(id)initWithMessage:(NSString *)messageText;

@end
