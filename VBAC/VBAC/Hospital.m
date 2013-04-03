//
//  Hospital.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "Hospital.h"

@implementation Hospital

- (id)initWithName:(NSString *)name State:(NSString *)state Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year {
    self = [super init];
    
    if (self) {
        _name = name;
        _state = state;
        _location = location;
        _number = number;
        _rate = rate;
        _year = year;
    }
    
    return self;
}

@end
