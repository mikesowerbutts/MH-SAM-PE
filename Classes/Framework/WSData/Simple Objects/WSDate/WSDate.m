//
//  WSDate.m
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSDate.h"
#import "WSDataModel.h"
#import "WSXMLObject.h"

@implementation WSDate
@synthesize date, dateFormatter, rawDate;
-(id)initWithString:(NSString *)dateStr{
	self.rawDate = [[NSString alloc] initWithString:@""];
	if(dateStr != nil && ![dateStr isEqualToString:@""]){
		self.rawDate = [dateStr stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		//[rawDate retain];
		NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
		[inputFormatter setDateFormat:@"yyyyMMdd"];
		self.date = [inputFormatter dateFromString:[rawDate stringByReplacingOccurrencesOfString:@"." withString:@""]];
		//[date retain];
		[inputFormatter release];
		
		self.dateFormatter = [[NSDateFormatter alloc] init];
		WSXMLObject *dateFmt = [[[WSDataModel instance] applicationData] Get:@"UserData/DateFormat/DisplayOrder"];
		WSXMLObject *dateSep = [[[WSDataModel instance] applicationData] Get:@"UserData/DateFormat/Separator"];
		NSString *dataDateFormat = (dateFmt != nil && ![dateFmt.innerXML isEqualToString:@""]) ? dateFmt.innerXML : @"mdy";
		NSString *dateSeperator = (dateSep != nil && [dateSep.innerXML isEqualToString:@""]) ? dateSep.innerXML : @"/";
		if([dataDateFormat isEqualToString:@"ymd"]){
			NSMutableString *fmt = [[NSMutableString alloc] initWithString:@"yyyy"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"MM"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"dd"];
			[dateFormatter setDateFormat:fmt];
			[fmt release];
		}
		else if([dataDateFormat isEqualToString:@"dmy"]){
			NSMutableString *fmt = [[NSMutableString alloc] initWithString:@"dd"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"MM"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"yyyy"];
			[dateFormatter setDateFormat:fmt];
			[fmt release];
		}
		else if([dataDateFormat isEqualToString:@"mdy"]){
			[dateFormatter setDateFormat:@"MMddyyyy"];
			NSMutableString *fmt = [[NSMutableString alloc] initWithString:@"MM"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"dd"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"yyyy"];
			[dateFormatter setDateFormat:fmt];
			[fmt release];
		}
		else if([dataDateFormat isEqualToString:@"ydm"]){
			[dateFormatter setDateFormat:@"yyyyddMM"];
			NSMutableString *fmt = [[NSMutableString alloc] initWithString:@"yyyy"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"dd"];
			[fmt appendString:dateSeperator];
			[fmt appendString:@"MM"];
			[dateFormatter setDateFormat:fmt];
			[fmt release];
		}
	}
	return self;
}
-(NSString *)getFormattedDate{
	if(![rawDate isEqualToString:@""]){
		NSString *fmtDate = [dateFormatter stringFromDate:date];
		return fmtDate != nil ? fmtDate : @"";
	}
	else{
		return @"";
	}
}
-(NSString *)getXMLFormattedDate{
	return rawDate != nil ? rawDate : @"";
}
-(void)dealloc{
	[super dealloc];
	[rawDate release];
	[date release];
	[dateFormatter release];
}
@end
