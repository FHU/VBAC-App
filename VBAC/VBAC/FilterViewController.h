//
//  FilterViewController.h
//  VBAC
//
//  Created by Richard Simpson on 4/1/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterDelegate <NSObject>

- (void)resetFilter;
- (void)filterWithSortOption:(int)option Rate:(double)rate Distance:(double)distance;

@end

@interface FilterViewController : UIViewController

@property (assign, nonatomic) id<FilterDelegate> delegate;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sortOptionSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *rateOptionSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *distanceOptionSegmentedControl;

- (IBAction)close:(id)sender;
- (IBAction)resetFilter:(id)sender;
- (IBAction)filter:(id)sender;

@end
