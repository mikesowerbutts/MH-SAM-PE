//
//  Utils.h
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSXMLObject.h"

@interface WSUtils : NSObject {

}
+(NSString *)StringFromNode:(WSXMLObject *)XmlNode;
+(UIColor *)UIColorFromHex:(NSString *)colorHex;
+(NSString *)CreateGUID;
+(void)LaunchURL:(NSString *)theURL;
+(NSString *)StringFromResourcesFile:(NSString *)theFileName;
+(NSString *)StringFromDocumentsFile:(NSString *)theFileName;
+(NSString *)GetDocsPath;
+(NSString *)MakeXMLStringSafe:(NSString *)theXMLString;
+(void)WriteStringToFile:(NSString *)theFileName stringToSave:(NSString *)theStringToSave;
+(NSString *)URLEncode:(NSString *)theString;
+(UIImage *)convertToGreyscale:(UIImage *)i;
+(NSString *)URLDecode:(NSString *)theString;
@end
