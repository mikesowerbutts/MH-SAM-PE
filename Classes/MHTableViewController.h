//
//  MHTableController.h
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 18/02/2011.
//  Copyright 2011 White Springs Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTableViewController.h"
#import "MHRepositoryDialog.h"

@interface MHTableViewController : WSTableViewController {
	int flagOffset;
	BOOL flaggable;
    NSString *repositoryXPath;
    WSButton *repBtn;
    WSButtonController *repBtnController;
    MHRepositoryDialog *repDialog;
    WSXMLObject *tblRepN;
    NSString *repDialogHeading;
}
@property(nonatomic)BOOL flaggable;
@property(nonatomic)int flagOffset;
@property(nonatomic, retain)NSString *repositoryXPath;
@property(nonatomic, retain)WSButton *repBtn;
@property(nonatomic, retain)WSButtonController *repBtnController;
@property(nonatomic, retain)MHRepositoryDialog *repDialog;
@property(nonatomic, retain)WSXMLObject *tblRepN;
@property(nonatomic, retain)NSString *repDialogHeading;
@end
