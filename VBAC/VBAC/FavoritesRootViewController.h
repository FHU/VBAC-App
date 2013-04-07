//
//  FavoritesRootViewController.h
//  VBAC
//
//  Created by Richard Simpson on 4/6/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "FavoritesViewController.h"
#import "PPRevealSideViewController.h"

@interface FavoritesRootViewController : UIViewController

@property (strong, nonatomic) NSArray *hospitals;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet FavoritesViewController *favoritesViewController;

- (id)initWithHospitals:(NSArray *)hospitals Menu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)openMenu:(id)sender;

@end
