//
//  FAQRootViewController.m
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "FAQRootViewController.h"

@interface FAQRootViewController ()

@end

@implementation FAQRootViewController

- (id)initWithMenu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _menuViewController = menu;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect window = [[UIScreen mainScreen] bounds];
    [self.view setFrame:window];
    
    //Replace menu button
    UIButton *menu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [menu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    _faqViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    //Add home view controller
//    [_faqViewController setDelegate:self];
    [_navigationController.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:_navigationController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)openMenu:(id)sender {
    if (!_menuViewController)
        _menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    [self.revealSideViewController pushViewController:_menuViewController onDirection:PPRevealSideDirectionLeft withOffset:_menuViewController.offset animated:YES];
}

@end
