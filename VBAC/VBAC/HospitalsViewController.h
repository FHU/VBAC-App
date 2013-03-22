//
//  HospitalsViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PPRevealSideViewController.h"
#import "HospitalCell.h"

@interface HospitalsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *scrollViewContent;
@property (strong, nonatomic) IBOutlet HospitalCell *hospitalCell;

- (void)loadTableView;
- (void)loadScrollView;

@end
