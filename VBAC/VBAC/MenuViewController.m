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
    
    CGRect window = [[UIScreen mainScreen] bounds];
    double height = window.size.height / 4;
    
    [_homeButton setFrame:CGRectMake(0, 0, _homeButton.frame.size.width, height)];
    [_searchButton setFrame:CGRectMake(0, _homeButton.frame.origin.y + height, _searchButton.frame.size.width, height)];
    [_favoritesButton setFrame:CGRectMake(0, _searchButton.frame.origin.y + height, _favoritesButton.frame.size.width, height)];
    [_faqButton setFrame:CGRectMake(0, _favoritesButton.frame.origin.y + height, _faqButton.frame.size.width, height)];
    
    [_homeLabel setFrame:CGRectMake(0, _homeLabel.frame.origin.y, _homeLabel.frame.size.width, _homeLabel.frame.size.height)];
    [_searchLabel setFrame:CGRectMake(0, _homeLabel.frame.origin.y + height, _searchLabel.frame.size.width, _homeLabel.frame.size.height)];
    [_favoritesLabel setFrame:CGRectMake(0, _searchLabel.frame.origin.y + height, _favoritesLabel.frame.size.width, _homeLabel.frame.size.height)];
    [_faqLabel setFrame:CGRectMake(0, _favoritesLabel.frame.origin.y + height, _faqLabel.frame.size.width, _faqLabel.frame.size.height)];
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
