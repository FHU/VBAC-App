//
//  LoadViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "Dataset.h"

@interface LoadViewController : UIViewController

@property (strong, nonatomic) Dataset *dataset;
@property (strong, nonatomic) NSArray *hospitals;

@end
