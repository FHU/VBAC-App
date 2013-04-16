//
//  HomeViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)openHospitals:(id)sender {
    [_delegate openHospitals];
}

- (IBAction)openFAQ:(id)sender {
    [_delegate openFAQ];
}

- (IBAction)bobcatSTRIKE:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.fhu.edu/blogs/cs/"]];
}

@end
