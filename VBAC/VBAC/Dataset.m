//
//  Dataset.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "Dataset.h"
#import "Hospital.h"

@implementation Dataset
@synthesize dataFilePath = _dataFilePath;
@synthesize hospitals = _hospitals;

#pragma mark - Custom Methods

- (id)init {
    self = [super init];
    
    if (self) {
        _dataFilePath = [[NSBundle mainBundle] pathForResource:@"vbac" ofType:@"xml"];
        
        [self refresh];
    }
    
    return self;
}

- (void)refresh {
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:_dataFilePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    _hospitals = [self generateArrayFromXML:doc];
}

- (NSMutableArray *)generateArrayFromXML:(GDataXMLDocument *)xmlDocument {    
    //XML nodes
    NSArray *hospitalsXML = [xmlDocument nodesForXPath:@"//rss/channel/hospital" error:nil];
    
    //Create arrays to hold parsed data
    NSMutableArray *hospitals = [[NSMutableArray alloc] init];
        
    //Hospitals
    for (GDataXMLElement *hospital in hospitalsXML) {
        NSString *name = [self extractFromXmlElement:hospital forName:@"name"].stringValue;
        NSString *state = [self extractFromXmlElement:hospital forName:@"state"].stringValue;
        NSString *location = [self extractFromXmlElement:hospital forName:@"location"].stringValue;
        double vbacNumber = [self extractFromXmlElement:hospital forName:@"vbacNumber"].stringValue.doubleValue;
        double vbacRate = [self extractFromXmlElement:hospital forName:@"vbacRate"].stringValue.doubleValue;
        NSString *year = [self extractFromXmlElement:hospital forName:@"year"].stringValue;
        
        //Create Speaker object
        Hospital *h = [[Hospital alloc] initWithName:name State:state Location:location Number:vbacNumber Rate:vbacRate Year:year];
        
        //Add to array
        [hospitals addObject:h];
    }
    
    return hospitals;
}

- (GDataXMLElement *)extractFromXmlElement:(GDataXMLElement *)element forName:(NSString *)fieldName {
    NSArray *arr = [element elementsForName:fieldName];
    if (arr.count > 0)
        return (GDataXMLElement *)[arr objectAtIndex:0];
    else
        return nil;
}

@end
