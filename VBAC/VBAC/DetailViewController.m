//
//  DetailViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/30/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    
    //Replace bar buttons
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backToHospitals) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.title = @"Hospital Details";
    
    [self swapImage];
    
    _titleLabel.text = _hospital.title;

    NSString *url = @"https://dl.dropbox.com/u/28409250/Contest%20Combo%20Graph/index.html";
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)backToHospitals {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toggleFavorites:(id)sender {
    if (_hospital.isFavorite)
        _hospital.isFavorite = NO;
    else
        _hospital.isFavorite = YES;
    
    [self swapImage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_HOSPITAL_DATA" object:nil];
}

- (void)swapImage {
    if (_hospital.isFavorite)
        [_unfavoriteButton setHidden:NO];
    else
        [_unfavoriteButton setHidden:YES];
}

@end
