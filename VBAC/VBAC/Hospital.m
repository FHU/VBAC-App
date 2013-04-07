//
//  Hospital.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital
@synthesize title = _title, state = _state, location = _location, number = _number, rate = _rate, year = _year, isFavorite = _isFavorite;

- (id)initWithTitle:(NSString *)title State:(NSString *)state Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year isFavorite:(BOOL)isFavorite {
    self = [super init];
    if (self) {
        _title = title;
        _state = state;
        _location = location;
        _number = number;
        _rate = rate;
        _year = year;
        _isFavorite = isFavorite;
        _subtitle = [NSString stringWithFormat:@"%0.1f%%", rate];
        
        if ([_title isEqualToString:@""])
            _title = @"Untitled";
        
        _coordinate.latitude = 35.4422038579111;
        _coordinate.longitude = -88.6394388183273;
    }
    return self;
}

- (NSString *)getRate {
    return [NSString stringWithFormat:@"%.0f%%", _rate];
}

- (double)distanceFromLocation:(MKUserLocation *)location {
    double distance = 0.0;
    
    //Compare locations
    
    return distance;
}

@end
