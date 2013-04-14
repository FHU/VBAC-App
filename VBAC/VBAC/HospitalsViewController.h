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
#import "FilterViewController.h"

@class Hospital;

@protocol HospitalsDelegate <NSObject>

- (void)pushDetailForHospital:(Hospital *)h;
- (void)openFilter:(FilterViewController *)fvc;

@end

@interface HospitalsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, FilterDelegate>

@property (assign, nonatomic) id<HospitalsDelegate> delegate;
@property (strong, nonatomic) NSArray *hospitals;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableArray *filteredResults;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *noHospitalsLabel;
@property (strong, nonatomic) FilterViewController *filterViewController;
@property (strong, nonatomic) UIView *scrollViewContent;
@property (strong, nonatomic) IBOutlet HospitalCell *hospitalCell;
@property (strong, nonatomic) NSMutableArray *hospitalSlides;
@property BOOL loadWithNearby;
@property BOOL foundLocation;
@property BOOL isFiltered;

- (void)loadTableView;
- (void)loadScrollView;
- (IBAction)openFilter:(id)sender;
- (void)performSearchNearby;
- (void)performSearchWithText:(NSString *)text;

@end
