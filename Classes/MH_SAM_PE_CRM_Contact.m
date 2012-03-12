//
//  MH_SAM_PE_CRM_Contact.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PE_CRM_Contact.h"
#import "MH_SAM_PE_CRM_Account.h"
#import "WSPE_DataModel.h"
#import "WSUtils.h"

@implementation MH_SAM_PE_CRM_Contact
-(MH_SAM_PE_CRM_Account *)getAccount{
	NSString *accountID = [self GetProp:@"AccountID"];
	if(accountID != @""){
		WSPE_DataModel *dm = (WSPE_DataModel *)[[WSDataModelManager instance] getByID:dataID];
		return [[dm getCRMAccountsList] getObjectByID:accountID];
	}
	return nil;
}
@end
