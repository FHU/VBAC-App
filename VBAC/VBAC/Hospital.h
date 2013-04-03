//
//  Hospital.h
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hospital : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *year;
@property double number;
@property double rate;

- (id)initWithName:(NSString *)name State:(NSString *)state Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year;

@end
