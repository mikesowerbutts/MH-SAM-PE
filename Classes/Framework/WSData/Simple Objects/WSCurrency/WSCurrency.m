//
//  WSCurrency.m
//  BlueSheet
//
//  Created by Toby Widdowson on 09/09/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSCurrency.h"
#import "WSDataModel.h"
#import "WSXMLObject.h"

@implementation WSCurrency
@synthesize rawValue, numFormatter, thouSep, decSep, symbol;
-(id)initWithString:(NSString *)theValue{
	WSXMLObject *thouSepN = [[[WSDataModel instance] getApplicationData] Get:@"UserData/CurrencyFormat/Thousands"];
	if(thouSepN == nil){
		thouSepN = [[[WSDataModel instance] getApplicationData] Get:@"UserData/CurrencyFormat/Commas"];
	}
	self.thouSep = (thouSepN != nil) ? thouSepN.innerXML : @",";
	WSXMLObject *decSepN = [[[WSDataModel instance] getApplicationData] Get:@"UserData/CurrencyFormat/Decimals"];
	self.decSep = (decSepN != nil) ? decSepN.innerXML : @".";
	WSXMLObject *symbolN = [[[WSDataModel instance] getApplicationData] Get:@"UserData/CurrencyFormat/Symbol"];
	self.symbol = (symbolN != nil) ? [symbolN.innerXML stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] : @"$";
	self.rawValue = [theValue stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	self.rawValue = [rawValue stringByReplacingOccurrencesOfString:symbol withString:@""];
	self.numFormatter = [[NSNumberFormatter alloc] init];
	[self.numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	return self;
}
-(NSString *)getFormattedValue{
	NSNumber *num = [numFormatter numberFromString:self.rawValue];
	NSString *fmtVal = [numFormatter stringFromNumber:num];
	fmtVal = [fmtVal stringByReplacingOccurrencesOfString:@"," withString:thouSep];
	fmtVal = [fmtVal stringByReplacingOccurrencesOfString:@"." withString:decSep];
	NSString *symCopy = [[NSString alloc] initWithString:symbol];
	fmtVal = [fmtVal stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return [symCopy stringByAppendingString:fmtVal];
}
@end
