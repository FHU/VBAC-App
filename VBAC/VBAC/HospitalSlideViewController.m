//
//  HospitalSlideViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/17/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalSlideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HospitalSlideViewController ()

@end

@implementation HospitalSlideViewController

- (id)initWithHospital:(Hospital *)hospital NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hospital = hospital;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleLabel.text = _hospital.title;
    _addressLabel.text = @"620 Skyline Dr.\nJackson, TN 38301\n";
    
    [self swapImage];
    
    [_panelView.layer setCornerRadius:10.0];
        
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

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
