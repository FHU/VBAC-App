//
//  FavoritesRootViewController.m
//  VBAC
//
//  Created by Richard Simpson on 4/6/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "FavoritesRootViewController.h"
#import "Dataset.h"

@interface FavoritesRootViewController ()

@end

@implementation FavoritesRootViewController

- (id)initWithHospitals:(NSArray *)hospitals Menu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hospitals = hospitals;
        _menuViewController = menu;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveData)
                                                     name:@"SAVE_HOSPITAL_DATA"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Replace menu button
    UIButton *menu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [menu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    _favoritesViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    [_favoritesViewController setHospitals:_hospitals];
    
    [_navigationController.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_navigationController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Custom methods

- (IBAction)openMenu:(id)sender {    
    if (!_menuViewController)
        _menuViewController = [[MenuViewController alloc] initWithHospitals:_hospitals NibName:@"MenuViewController" bundle:nil];
    
    [self.revealSideViewController pushViewController:_menuViewController onDirection:PPRevealSideDirectionLeft withOffset:_menuViewController.offset animated:YES];
}

- (void)saveData {
    [Dataset saveHospitalData:_hospitals];
}

@end
