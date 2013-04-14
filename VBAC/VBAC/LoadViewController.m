//
//  LoadViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "LoadViewController.h"
#import "SVProgressHUD.h"
#import "MenuViewController.h"
#import "HomeRootViewController.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [SVProgressHUD show];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)loadData {
    if (!_hospitals) {
        //Load data
        _hospitals = [Dataset loadHospitalData];
        
        for (int count = 0; count < _hospitals.count; count++) {
            NSLog(@"Hospital %i", count + 1);
        }
        
        [SVProgressHUD dismiss];
        
        //Go home
        [self goToHome];
    }
}

- (void)goToHome {
    MenuViewController *menu = [[MenuViewController alloc] initWithHospitals:_hospitals NibName:@"MenuViewController" bundle:nil];
    HomeRootViewController *home = [[HomeRootViewController alloc] initWithHospitals:_hospitals Menu:menu NibName:@"HomeRootViewController" bundle:nil];
    
    CGRect window = [[UIScreen mainScreen] bounds];
    [menu.view setFrame:window];
    [home.view setFrame:window];
        
    [self.revealSideViewController popViewControllerWithNewCenterController:home animated:YES];
}

@end
