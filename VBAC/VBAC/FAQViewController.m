//
//  FAQViewController.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "FAQViewController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController

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
    
    /*NSString * path = @"https://dl.dropbox.com/u/28409250/Contest%20FAQ/index.html"; */
    
    NSString * path = @"https://dl.dropbox.com/u/28409250/Richard%27s%20Suggestion/index.html";
    
    [_FAQWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: path]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
