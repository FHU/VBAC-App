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
#import "FilterViewController.h"

@interface HospitalsRootViewController : UIViewController <UISearchBarDelegate, HospitalsDelegate>

@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet HospitalsViewController *hospitalsViewController;
@property (strong, nonatomic) FilterViewController *filterViewController;
@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

- (id)initWithMenu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)openMenu:(id)sender;
- (IBAction)changeViewType:(id)sender;
- (void)beginEditing;

@end
