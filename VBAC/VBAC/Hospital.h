//
//  Hospital.h
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Hospital : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *year;
@property double number;
@property double rate;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title State:(NSString *)state Location:(NSString *)location Number:(double)number Rate:(double)rate Year:(NSString *)year;

@end
