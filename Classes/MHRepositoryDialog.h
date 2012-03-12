//
//  MHRepositoryDialog.h
//  MH SAM PE
//
//  Created by Toby Widdowson on 17/11/2011.
//  Copyright (c) 2011 White Springs Ltd. All rights reserved.
//

#import "WSEditDialogController.h"
#import "WSXMLObject.h"
#import "WSTableViewController.h"
#import "WSTableViewDataController.h"

@interface MHRepositoryDialog : WSEditDialogController {
    WSXMLObject *XMLData;
    WSTableViewController *tableViewController;
}
@property(nonatomic, retain)WSXMLObject *XMLData;
@property(nonatomic, retain)WSTableViewController *tableViewController;

-(id)initWithXIBAndIDDontShow:(NSString *)theNibName mainView:(UIView *)theDispView ID:(NSString *)theID xmlData:(WSXMLObject *)theXMLData;
@end
