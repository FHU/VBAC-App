//
//  HomeRootViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "Dataset.h"
#import "MenuViewController.h"
#import "HomeViewController.h"

@interface HomeRootViewController : UIViewController <HomeViewDelegate>

@property (strong, nonatomic) Dataset *dataset;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet HomeViewController *homeViewController;

- (id)initWithDataset:(Dataset *)dataset Menu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)openMenu:(id)sender;

@end
