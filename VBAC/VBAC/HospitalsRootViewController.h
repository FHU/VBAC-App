//
//  HospitalsRootViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "MenuViewController.h"
#import "HospitalsViewController.h"

@interface HospitalsRootViewController : UIViewController <UISearchBarDelegate, HospitalsDelegate>

@property (strong, nonatomic) NSArray *hospitals;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet HospitalsViewController *hospitalsViewController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property BOOL loadWithNearby;

- (id)initWithHospitals:(NSArray *)hospitals Menu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)openMenu:(id)sender;
- (IBAction)changeViewType:(id)sender;
- (void)beginEditing;
- (void)performSearchNearby;

@end
