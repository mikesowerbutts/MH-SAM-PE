//
//  MHAppletViewController.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 23/05/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import "MHAppletViewController.h"
#import "WSDataModel.h"

@implementation MHAppletViewController
@synthesize saveBtn, exitBtn;
- (void)viewDidLoad{
    [super viewDidLoad];
    WSDataModel *dm = [[WSDataModelManager instance] getByID:ID];
    if(dm != nil){
        if([[dm readOnly] value]){
            UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"Record Locked" message:@"You are not authorized to update this item, it will be opened as Read Only" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            [al show];
            al.tag = 999;
            self.saveBtn.enabled = NO;
            self.saveBtn.alpha = 0.5;
        }
        else if([[dm manager] value]){
            UIAlertView *al = [[[UIAlertView alloc] initWithTitle:@"Manager's Edition" message:@"This item has been opened in Manager's Mode, where the majority of fields are locked" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
            al.tag = 999;
            [al show];
        }
    }
}
-(void)dealloc{
    [super dealloc];
    [saveBtn release];
    [exitBtn release];
}
@end
