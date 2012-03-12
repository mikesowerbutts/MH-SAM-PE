//
//  Utils.m
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSUtils.h"
#import "WSXMLObject.h"
#import "WSURLConnection.h"
#import "WSURLConnectionManager.h"

@implementation WSUtils
+(NSString *)StringFromNode:(WSXMLObject *)XmlNode{
	NSString *val = [[NSString alloc] initWithString:@""];
	if(XmlNode != nil){
		val = XmlNode.innerXML;
	}
	return val;
}
+(UIColor *)colorWithRGBHex:(UInt32)hex{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f];
}
+(UIColor *)UIColorFromHex:(NSString*)colorHex{
	NSScanner *scanner = [NSScanner scannerWithString:colorHex];
	unsigned hexNum;
	if(![scanner scanHexInt:&hexNum]) return nil;
	return [WSUtils colorWithRGBHex:hexNum];
}
+(NSString *)CreateGUID{
	CFUUIDRef uuidRef = CFUUIDCreate(NULL);
	CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
	NSString *uuid = [NSString stringWithString:(NSString *)uuidStringRef];
	CFRelease(uuidStringRef);
	uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
	return uuid;
}
+(void)LaunchURL:(NSString *)theURL{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:theURL]];
}
+(NSString *)StringFromResourcesFile:(NSString *)theFileName{
	NSString *filename = [[NSBundle mainBundle] pathForResource:theFileName ofType:@"xml"];
	NSString *content = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
	return content;
}
+(NSString *)StringFromDocumentsFile:(NSString *)theFileName{
	NSString *filename = [NSString stringWithFormat:@"%@/%@.%@", [WSUtils GetDocsPath], theFileName, @"xml"];
	NSString *content = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
	return content;
}
+(void)WriteStringToFile:(NSString *)theFileName stringToSave:(NSString *)theStringToSave{
	//NSLog(@"writing to file: %@, data: %@", theFileName, theStringToSave);
	NSString *filename = [NSString stringWithFormat:@"%@/%@.%@", [WSUtils GetDocsPath], theFileName, @"xml"];
	[theStringToSave writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:nil];
}
+(NSString *)GetDocsPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}
+(NSString *)MakeXMLStringSafe:(NSString *)theXMLString{
	theXMLString = [theXMLString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	theXMLString = [theXMLString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
	theXMLString = [theXMLString stringByReplacingOccurrencesOfString:@"  " withString:@""];
	theXMLString = [theXMLString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	theXMLString = [theXMLString stringByReplacingOccurrencesOfString:@"> <" withString:@"><"];
	return theXMLString;
}
+(NSString *)URLEncode:(NSString *)theString{
	if([theString rangeOfString:@"%"].location != NSNotFound){
		theString = [theString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	NSString *encStr = [[NSString alloc] initWithString:[theString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	return encStr;
}
+(NSString *)URLDecode:(NSString *)theString{
	if(theString != nil){
		NSString *decStr = [[NSString alloc] initWithString:[theString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		return decStr;
	}
	else{
		return @"";
	}
}
+(UIImage *)convertToGreyscale:(UIImage *)i{ 
	
    int kRed = 1; 
    int kGreen = 2; 
    int kBlue = 4; 
	
    int colors = kGreen; 
    int m_width = i.size.width; 
    int m_height = i.size.height; 
	
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t)); 
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast); 
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh); 
    CGContextSetShouldAntialias(context, NO); 
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]); 
    CGContextRelease(context); 
    CGColorSpaceRelease(colorSpace); 
	
    // now convert to grayscale 
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height); 
    for(int y = 0; y < m_height; y++) { 
        for(int x = 0; x < m_width; x++) { 
			uint32_t rgbPixel=rgbImage[y*m_width+x]; 
			uint32_t sum=0,count=0; 
			if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;} 
			if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;} 
			if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;} 
			m_imageData[y*m_width+x]=sum/count; 
        } 
    } 
    free(rgbImage); 
	
    // convert from a gray scale image back into a UIImage 
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1); 
	
    // process the image back to rgb 
    for(int i = 0; i < m_height * m_width; i++) { 
        result[i*4]=0; 
        int val=m_imageData[i]; 
        result[i*4+1]=val; 
        result[i*4+2]=val; 
        result[i*4+3]=val; 
    } 
	
    // create a UIImage 
    colorSpace = CGColorSpaceCreateDeviceRGB(); 
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast); 
    CGImageRef image = CGBitmapContextCreateImage(context); 
    CGContextRelease(context); 
    CGColorSpaceRelease(colorSpace); 
    UIImage *resultUIImage = [UIImage imageWithCGImage:image]; 
    CGImageRelease(image); 
	
    // make sure the data will be released by giving it to an autoreleased NSData 
    [NSData dataWithBytesNoCopy:result length:m_width * m_height]; 
	
    return resultUIImage; 
} 

@end
