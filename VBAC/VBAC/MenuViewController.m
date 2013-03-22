//
//  MenuViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewController.h"
#import "HomeRootViewController.h"
#import "HospitalsRootViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _offset = 150.0;
        _isDisplayed = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewDidAppear:(BOOL)animated {
    _isDisplayed = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    _isDisplayed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)goToHome:(id)sender {
//    [_delegate goToHome];
    HomeRootViewController *home = [[HomeRootViewController alloc] initWithMenu:self NibName:@"HomeRootViewController" bundle:nil];
    
    [self.revealSideViewController popViewControllerWithNewCenterController:home animated:YES];
}

- (void)goToSearch:(id)sender {
//    [_delegate goToSearch];
}

- (void)goToFavorites:(id)sender {
//    [_delegate goToFavorites];
}

- (void)goToFAQ:(id)sender {
//    [_delegate goToFAQ];
}

@end
