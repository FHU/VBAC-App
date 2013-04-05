//
//  Dataset.h
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface Dataset : NSObject

@property (strong, nonatomic) NSString *dataFilePath;
@property (strong, nonatomic) NSArray *hospitals;

+ (NSArray *)loadHospitalData;
+ (void)saveHospitalData:(NSArray *)hospitals;

@end
