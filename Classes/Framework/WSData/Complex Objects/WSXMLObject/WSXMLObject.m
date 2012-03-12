//
//  WSXMLObject.m
//  BlueSheet
//
//  Created by Toby Widdowson on 11/05/2010.
//  Copyright 2010 White Springs Ltd. All rights reserved.
//

#import "WSXMLObject.h"
#import "WSKVPair.h"

@implementation WSXMLObject
@synthesize name, outerXML, innerXML, children, attributes, parent;

-(id)init:(NSString *)theXML
{
	self.children = [[NSMutableDictionary alloc] init];
	self.attributes = [[NSMutableDictionary alloc] init];
	self.outerXML = [[NSString alloc] initWithString:theXML];
	NSInteger dupCounter = 0;
	NSRange rootRange = [outerXML rangeOfString:@">"];
	rootRange.length = rootRange.location + 1;
	rootRange.location = 0;
	NSString *startTag = [outerXML substringWithRange:rootRange];
	NSInteger l = [startTag rangeOfString:@" "].location + 1;
	if([startTag rangeOfString:@" "].location != NSNotFound)
	{
		NSString *atts = [startTag substringWithRange:NSMakeRange(l, [startTag rangeOfString:@">"].location - l)];
		if([startTag rangeOfString:@"/>"].location != NSNotFound){
			atts = [startTag substringWithRange:NSMakeRange(l, [startTag rangeOfString:@">"].location - (l+1))];
		}
		NSMutableArray *attsParts = [[NSMutableArray alloc] init];
		BOOL end = NO;
		while(!end){
			if(atts.length > 0){
				if(([atts rangeOfString:@"' "].location != NSNotFound && [atts rangeOfString:@"\" "].location != NSNotFound) || ([[atts substringWithRange:NSMakeRange(atts.length-1, 1)] isEqualToString:@"'"] || [[atts substringWithRange:NSMakeRange(atts.length-1, 1)] isEqualToString:@"\""])){
					NSInteger sIdx = 0;
					if([[atts substringWithRange:NSMakeRange(0, 1)] isEqualToString:@" "]){sIdx = 1;}
					NSInteger eIdx = [atts rangeOfString:@"' "].location;
					if([atts rangeOfString:@"' "].location == NSNotFound)
					{
						eIdx = [atts rangeOfString:@"\" "].location;
					}
					if([atts rangeOfString:@"' "].location == NSNotFound && [atts rangeOfString:@"\" "].location == NSNotFound){eIdx = atts.length - 1;}
					NSRange attRange = NSMakeRange(sIdx, eIdx+1);
					NSString *str = [atts substringWithRange:attRange];
					[attsParts addObject:str];
					atts = [atts stringByReplacingOccurrencesOfString:str withString:@""];
					if(atts.length > 0){
						if([[atts substringWithRange:NSMakeRange(0, 1)] isEqualToString:@" "]){
							atts = [atts substringWithRange:NSMakeRange(1, atts.length - 1)];
						}
					}
				}
			}
			else{
				end = YES;
			}
		}
		for(NSString *att in attsParts){
			NSArray *attParts = [att componentsSeparatedByString:@"="];
			if(attParts.count == 2){
				NSString *val = [[attParts objectAtIndex:1] stringByReplacingOccurrencesOfString:@"'" withString:@""];
				val = [[attParts objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
				NSString *key = [[attParts objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@""];
				[attributes setObject:val forKey:key];
			}
		}
		[attsParts release];
		startTag = [startTag substringWithRange:NSMakeRange(0, l)];
	}
	self.name = [[NSString alloc] initWithString:[startTag substringWithRange:NSMakeRange(1, startTag.length - 2)]];
	NSMutableString *endT = [[NSMutableString alloc] initWithString:@"</"];
	[endT appendString:self.name];
	[endT appendString:@">"];
	NSString *endTag = [[NSString alloc] initWithString:@""];
	if([outerXML rangeOfString:endT].location == NSNotFound){
		
		endTag = @"/>";
	}
	else{
		endTag = [[NSString alloc] initWithString:@"</"];
		endTag = [endTag stringByAppendingString:name];
		endTag = [endTag stringByAppendingString:@">"];
	}
	NSRange innerXMLRange = NSMakeRange(rootRange.length, [outerXML rangeOfString:endTag].location - rootRange.length);
	if([outerXML rangeOfString:endTag].location == NSNotFound)
	{
		[endT release];
		//[endTag release];
		return self;
	}
	[endT release];
	//[endTag release];
	innerXML = [[NSString alloc] initWithString:@""];
	NSInteger innerLen = innerXMLRange.length;
	if(innerLen > 0)
	{
		self.innerXML = [outerXML substringWithRange:innerXMLRange];
		self.innerXML = [innerXML stringByReplacingOccurrencesOfString:@"\t" withString:@""];
	}
	NSInteger inLen = [innerXML length];
	if(inLen > 0){
		NSString *tempXML = innerXML;
		NSRange childRange = NSMakeRange(0, 0);
		while(childRange.location != NSNotFound)
		{
			if([tempXML rangeOfString:@"<"].location == NSNotFound)
			{
				break;
			}
			else
			{
				NSRange ran = NSMakeRange(0, [tempXML rangeOfString:@">"].location + 1);
				NSInteger ranLen = ran.length;
				if(ranLen > 0){
					NSString *childStartTag = [tempXML substringWithRange:ran];
					NSInteger cl = [childStartTag rangeOfString:@" "].location + 1;
					if([childStartTag rangeOfString:@" "].location != NSNotFound){
						childStartTag = [childStartTag substringWithRange:NSMakeRange(0, cl)];
					}
					childStartTag = [childStartTag substringWithRange:NSMakeRange(1, childStartTag.length - 2)];
					NSMutableString *childEndTag = [[NSMutableString alloc] initWithString:@"</"];
					[childEndTag appendString:childStartTag];
					[childEndTag appendString:@">"];
					childRange = NSMakeRange(0, [tempXML rangeOfString:childEndTag].location + childEndTag.length);
					if([tempXML rangeOfString:childEndTag].location == NSNotFound){
						childRange = NSMakeRange(0, [tempXML rangeOfString:@"/>"].location + 2);
					}
					[childEndTag release];
					NSString *childNodeXML = [tempXML substringWithRange:childRange];
					if(![[childNodeXML substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"<!--"]){
						WSXMLObject *obj = [[WSXMLObject alloc] init:childNodeXML];
						if([children valueForKey:obj.name] != nil){
							NSString *c = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d", dupCounter]];
							dupCounter++;
							obj.name = [obj.name stringByAppendingFormat:c];
							[c release];
						}
						[children setObject:obj forKey:obj.name];
						[obj release];
					}
					tempXML = [tempXML stringByReplacingOccurrencesOfString:childNodeXML withString:@""];
					if(childNodeXML.length == 0)
					{
						childRange.location = NSNotFound;
					}
					else
					{
						childRange = [tempXML rangeOfString:@">"];
					}
				}
				else{
					childRange.location = NSNotFound;
				}
			}
		}
	}
	return self;
}

-(id)Get:(NSString *)objName
{
	NSArray *pathParts = [objName componentsSeparatedByString:@"/"];
	NSArray *keys = [self.children allKeys];
	if([keys containsObject:[pathParts objectAtIndex:0]])
	{
		if([pathParts count] > 1)
		{
			WSXMLObject *obj = self;
			WSXMLObject *obj2;
			for(NSString *part in pathParts)
			{
				if([part intValue] != 0 || [part isEqualToString:@"0"])
				{
					obj2 = [obj GetByIndex:[part intValue]];		
				}
				else
				{
					obj2 = [obj.children valueForKey:part];
				}
				obj = obj2;
			}
			return obj;
		}
		else
		{
			return [children valueForKey:[pathParts objectAtIndex:0]];
		}
	}
	else
	{
		return nil;	
	}
}
-(id)GetByIndex:(NSUInteger)idx
{
	NSArray *keys = [children allKeys];
	if(idx < [keys count])
	{
		WSXMLObject *obj = [children valueForKey:[keys objectAtIndex:idx]];
		return [[obj retain] autorelease];
	}
	else
	{
		return nil;	
	}
}
-(NSString *)GetAttribute:(NSString *)attName
{
	NSArray *keys = [attributes allKeys];
	if([keys containsObject:attName])
	{
		return [attributes valueForKey:attName];
	}
	else
	{
		return nil;	
	}
}
-(WSKVPair *)GetAttributeKVPair:(NSString *)attName
{
	NSArray *keys = [attributes allKeys];
	if([keys containsObject:attName])
	{
		return [[WSKVPair  alloc] initWithKeyValue:attName aValue:[attributes valueForKey:attName]];
	}
	else
	{
		return nil;	
	}
}
-(void)SetAttribute:(NSString *)attName newAttValue:(NSString *)newValue
{
	NSArray *keys = [attributes allKeys];
	if([keys containsObject:attName]){
		[attributes setValue:newValue forKey:attName];
	}
}
-(NSString *)GetAttributeByIndex:(NSUInteger)idx
{
	NSArray *keys = [attributes allKeys];
	if(idx < [keys count])
	{
		return [attributes valueForKey:[keys objectAtIndex:idx]];
	}
	else
	{
		return nil;	
	}
}
-(NSMutableArray *)GetChildAttributesByName:(NSString *)attName
{
	NSMutableArray *vals = [[[NSMutableArray alloc] initWithCapacity:attributes.count] autorelease];
	for(WSXMLObject *obj in [children allValues])
	{
		NSString *att = [obj GetAttribute:attName];
		[vals addObject:att];
		[att release];
	}
	return vals;
}
-(WSXMLObject *)GetByAttributeValue:(NSString *)attName attValue:(NSString *)attValue{
	for(int i = 0; i < [children count]; i++){
		WSXMLObject *obj = [[children allValues] objectAtIndex:i];
		WSKVPair *attPair = [obj GetAttributeKVPair:attName];
		if(attPair != nil){
			if(attPair.value != nil && [attPair.value isEqualToString:attValue]){
				return obj;
			}
		}
	}
	return nil;
}
-(void)ReplaceChildNode:(NSString *)theXPathToChildNode replacementNode:(WSXMLObject *)theReplacementNode{
	WSXMLObject *oldNode = [self Get:theXPathToChildNode];
	if(oldNode != nil){
		[children setObject:theReplacementNode forKey:oldNode.name];
	}
	else{
		[children setObject:theReplacementNode forKey:theReplacementNode.name];
	}
}
-(void)RefreshXMLProperties{
	NSMutableString *newInnerXML = [[NSMutableString alloc] init];
	for(int i = 0; i < [children count]; i++){
		WSXMLObject *obj = [[children allValues] objectAtIndex:i];
		[obj RefreshXMLProperties];
		[newInnerXML appendString:obj.outerXML];
	}
	if([children count] > 0){
		innerXML = newInnerXML;
	}
	self.outerXML = [[NSString alloc] initWithFormat:@"<%@>%@</%@>", name, innerXML, name];
}
-(void)dealloc
{
	[name release];
	[innerXML release];
	[children release];
	[attributes release];
	[parent release];
	[outerXML release];
	[super dealloc];
}

@end
