//
//  Hospital.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "Hospital.h"
#import <CoreLocation/CoreLocation.h>

@implementation Hospital
@synthesize title = _title, street = _street, city = _city, state = _state, zip = _zip, location = _location, number = _number, rate = _rate, year = _year, isFavorite = _isFavorite;

- (id)initWithTitle:(NSString *)title Street:(NSString *)street City:(NSString *)city State:(NSString *)state Zip:(NSString *)zip Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year isFavorite:(BOOL)isFavorite {
    self = [super init];
    if (self) {
        _title = title;
        _street = street;
        _city = city;
        _state = state;
        _zip = zip;
        _location = location;
        _number = number;
        _rate = rate;
        _year = year;
        _isFavorite = isFavorite;
        _subtitle = [NSString stringWithFormat:@"%0.1f%%", rate];
        
        if ([_title isEqualToString:@""])
            _title = @"Untitled";
        
        _coordinate.latitude = [[[location componentsSeparatedByString:@", "] objectAtIndex:0] doubleValue];
        _coordinate.longitude = [[[location componentsSeparatedByString:@", "] objectAtIndex:1] doubleValue];
    }
    return self;
}

- (NSString *)getRate {
    return [NSString stringWithFormat:@"%.0f%%", _rate];
}

- (double)distanceFromLocation:(MKUserLocation *)location {    
    //Compare locations
    CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    CLLocation *hospitalLocation = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    
    CLLocationDistance distance = [hospitalLocation distanceFromLocation:userLocation]; //Meters
    double miles = distance * 0.000621371;  //1 meter = 0.000621371 miles
    
    return miles;
}

@end
