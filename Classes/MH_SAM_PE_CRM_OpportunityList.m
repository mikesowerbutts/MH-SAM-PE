//
//  MH_SAM_PE_CRM_OpportunityList.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 11/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PE_CRM_OpportunityList.h"
#import "MH_SAM_PE_CRM_Opportunity.h"

@implementation MH_SAM_PE_CRM_OpportunityList
-(void)buildList{
	for(int i = 0; i < [[xml children] count]; i++){
		WSXMLObject *obj = [xml GetByIndex:i];
		MH_SAM_PE_CRM_Opportunity *opp = [[MH_SAM_PE_CRM_Opportunity alloc] initWithXML:obj ID:ID];
		[items addObject:opp];
	}
}

@end
