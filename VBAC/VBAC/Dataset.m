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

+ (NSString *)dataFilePath:(BOOL)forSave {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"vbac.xml"];
    
    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
        return documentsPath;
    else
        return [[NSBundle mainBundle] pathForResource:@"vbac" ofType:@"xml"];
    
}

+ (NSArray *)loadHospitalData {
    NSString *filePath = [self dataFilePath:FALSE];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    //XML nodes
    NSArray *hospitalsXML = [document nodesForXPath:@"channel/hospital" error:nil];
    
    //Create arrays to hold parsed data
    NSMutableArray *hospitals = [[NSMutableArray alloc] init];
    
    //Hospitals
    for (GDataXMLElement *hospital in hospitalsXML) {
        //Create variables to fill in
        NSString *name;
        NSString *street;
        NSString *city;
        NSString *state;
        NSString *zip;
        NSString *location;
        double vbacNumber = 0.0;
        double vbacRate = 0.0;
        NSString *year;
        BOOL isFavorite = NO;
        
        //Name
        NSArray *names = [hospital elementsForName:@"name"];
        if (names.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[names objectAtIndex:0];
            name = element.stringValue;
        }
        
        //Street
        NSArray *streets = [hospital elementsForName:@"street"];
        if (streets.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[streets objectAtIndex:0];
            street = element.stringValue;
        }
        
        //City
        NSArray *cities = [hospital elementsForName:@"city"];
        if (cities.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[cities objectAtIndex:0];
            city = element.stringValue;
        }
        
        //State
        NSArray *states = [hospital elementsForName:@"state"];
        if (states.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[states objectAtIndex:0];
            state = element.stringValue;
        }
        
        //Zip
        NSArray *zips = [hospital elementsForName:@"zip"];
        if (zips.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[zips objectAtIndex:0];
            zip = element.stringValue;
        }
        
        //Location
        NSArray *locations = [hospital elementsForName:@"location"];
        if (locations.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[locations objectAtIndex:0];
            location = element.stringValue;
        }
        
        //VBACNumber
        NSArray *vbacNumbers = [hospital elementsForName:@"vbacNumber"];
        if (vbacNumbers.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[vbacNumbers objectAtIndex:0];
            vbacNumber = element.stringValue.doubleValue;
        }
        
        //VBACRate
        NSArray *vbacRates = [hospital elementsForName:@"vbacRate"];
        if (vbacRates.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[vbacRates objectAtIndex:0];
            vbacRate = element.stringValue.doubleValue;
        }
        
        //Year
        NSArray *years = [hospital elementsForName:@"year"];
        if (years.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[years objectAtIndex:0];
            year = element.stringValue;
        }
        
        //isFavorite
        NSArray *favorites = [hospital elementsForName:@"isFavorite"];
        if (favorites.count > 0) {
            GDataXMLElement *element = (GDataXMLElement *)[favorites objectAtIndex:0];
            isFavorite = element.stringValue.boolValue;
        }
        
        //Create Hospital object
        Hospital *h = [[Hospital alloc] initWithTitle:name Street:street City:city State:state Zip:zip Location:location Number:vbacNumber Rate:vbacRate Year:year isFavorite:isFavorite];
        
        //Add to array
        [hospitals addObject:h];
    }
    
    return hospitals;
}

+ (void)saveHospitalData:(NSArray *)hospitals {
    GDataXMLElement *channel = [GDataXMLNode elementWithName:@"channel"];
    
    for (Hospital *h in hospitals) {
        GDataXMLElement *hospital = [GDataXMLNode elementWithName:@"hospital"];
        GDataXMLElement *name = [GDataXMLNode elementWithName:@"name" stringValue:h.title];
        GDataXMLElement *street = [GDataXMLNode elementWithName:@"street" stringValue:h.street];
        GDataXMLElement *city = [GDataXMLNode elementWithName:@"city" stringValue:h.city];
        GDataXMLElement *state = [GDataXMLNode elementWithName:@"state" stringValue:h.state];
        GDataXMLElement *zip = [GDataXMLNode elementWithName:@"zip" stringValue:h.zip];
        GDataXMLElement *location = [GDataXMLNode elementWithName:@"location" stringValue:h.location];
        GDataXMLElement *vbacNumber = [GDataXMLNode elementWithName:@"vbacNumber" stringValue:[NSString stringWithFormat:@"%f", h.number]];
        GDataXMLElement *vbacRate = [GDataXMLNode elementWithName:@"vbacRate" stringValue:[NSString stringWithFormat:@"%f", h.rate]];
        GDataXMLElement *year = [GDataXMLNode elementWithName:@"year" stringValue:h.year];
        
        NSString *booleanValue = (h.isFavorite) ? @"True" : @"False";
        GDataXMLElement *isFavorite = [GDataXMLNode elementWithName:@"isFavorite" stringValue:booleanValue];
        
        [hospital addChild:name];
        [hospital addChild:street];
        [hospital addChild:city];
        [hospital addChild:state];
        [hospital addChild:zip];
        [hospital addChild:location];
        [hospital addChild:vbacNumber];
        [hospital addChild:vbacRate];
        [hospital addChild:year];
        [hospital addChild:isFavorite];
        
        [channel addChild:hospital];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:channel];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:YES];
    NSLog(@"Saving xml data to %@...", filePath);
    
    //Write the data
    [xmlData writeToFile:filePath atomically:YES];
}
/*
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
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    
    _hospitals = [self generateArrayFromXML:document];
}

- (NSMutableArray *)generateArrayFromXML:(GDataXMLDocument *)document {
    //XML nodes
    NSArray *hospitalsXML = [document nodesForXPath:@"//rss/channel/hospital" error:nil];
    
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
        BOOL isFavorite = [self extractFromXmlElement:hospital forName:@"isFavorite"].stringValue.boolValue;
        
        //Create Speaker object
        Hospital *h = [[Hospital alloc] initWithTitle:name State:state Location:location Number:vbacNumber Rate:vbacRate Year:year];
        h.isFavorite = isFavorite;
        
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
*/
@end
