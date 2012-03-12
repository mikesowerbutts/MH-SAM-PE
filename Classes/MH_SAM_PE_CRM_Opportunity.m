//
//  MH_SAM_PE_CRM_Opportunity.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PE_CRM_Opportunity.h"
#import "WSUtils.h"
#import "MH_SAM_PE_CRM_Account.h"

@implementation MH_SAM_PE_CRM_Opportunity
-(MH_SAM_PE_CRM_Account *)getAccount{
	NSString *accountID = [self GetProp:@"AccountID"];
	if(accountID != @""){
		WSPE_DataModel *dm = (WSPE_DataModel *)[[WSDataModelManager instance] getByID:dataID];
		return [[dm getCRMAccountsList] getObjectByID:accountID];
	}
	return nil;
}
-(NSString *)getAccountName{
	MH_SAM_PE_CRM_Account *acc = [self getAccount];
	if(acc != nil){
		return acc.name;
	}
	return @"";
}
@end

