//
//  Hospital.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

- (id)initWithTitle:(NSString *)title State:(NSString *)state Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year {
    self = [super init];
    if (self) {
        _title = title;
        _state = state;
        _location = location;
        _number = number;
        _rate = rate;
        _year = year;
        
        if ([_title isEqualToString:@""])
            _title = @"Untitled";
        
        _coordinate.latitude = 35.4422038579111;
        _coordinate.longitude = -88.6394388183273;
    }
    return self;
}

@end
