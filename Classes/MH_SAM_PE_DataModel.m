//
//  MH_SAM_PE_DataModel.m
//  MH SAM PE
//
//  Created by Mike Sowerbutts on 08/10/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "MH_SAM_PE_DataModel.h"
#import "MH_SAM_PE_CRM_OpportunityList.h"
#import "MH_SAM_PE_CRM_Opportunity.h"

@implementation MH_SAM_PE_DataModel
-(id)init:(NSString *)filename ID:(NSString *)theID{
	self.ID = theID;
	[super init:filename ID:theID];
	[self initVars];
	return self;
}
@end
