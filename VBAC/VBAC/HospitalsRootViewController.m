//
//  HospitalsRootViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalsRootViewController.h"
#import "DetailViewController.h"
#import "Dataset.h"

@interface HospitalsRootViewController ()

@end

@implementation HospitalsRootViewController

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
        
        _loadWithNearby = NO;
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
    
    _hospitalsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    [_viewSegmentedControl setBackgroundImage:[[UIImage imageNamed:@"segment_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_viewSegmentedControl setBackgroundImage:[[UIImage imageNamed:@"segment_selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [_hospitalsViewController setDelegate:self];
    [_hospitalsViewController setHospitals:_hospitals];
    [_hospitalsViewController setLoadWithNearby:_loadWithNearby];
    
    //Remove search bar background
    for (UIView *subview in _searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [_searchBar setDelegate:self];
        
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
    [self dismissKeyboard];
    
    if (!_menuViewController)
        _menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        
    [self.revealSideViewController pushViewController:_menuViewController onDirection:PPRevealSideDirectionLeft withOffset:_menuViewController.offset animated:YES];
}

- (IBAction)changeViewType:(id)sender {
    [self dismissKeyboard];
    
    switch (_viewSegmentedControl.selectedSegmentIndex) {
        case 0:
            [_hospitalsViewController loadScrollView];
            break;
        case 1:
            [_hospitalsViewController loadTableView];
            break;
        default:
            break;
    }
}

- (void)beginEditing {
    [self.searchBar becomeFirstResponder];
}

- (void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

- (void)saveData {
    [Dataset saveHospitalData:_hospitals];
}

- (void)performSearchNearby {
    [_hospitalsViewController performSearchNearby];
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //Do not allow editing if the left side menu is displayed
    if (_menuViewController.isDisplayed)
        return NO;
    else
        return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //Replace the right bar button item with a close button
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 71, 31)];
    [close setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    _hospitalsViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:close];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //Put back the segmented controller
    _hospitalsViewController.navigationItem.rightBarButtonItem = _rightBarButtonItem;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {    
    //Dismiss keyboard
    [self.searchBar resignFirstResponder];
    
    //Perform search
    [_hospitalsViewController performSearchWithText:searchBar.text];
}

#pragma mark - HospitalsDelegate

- (void)pushDetailForHospital: (Hospital *) hospital {
    [self dismissKeyboard];
    
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    dvc.hospital = hospital;
    
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)openFilter:(FilterViewController *)fvc {
    [self dismissKeyboard];
    
    [self.navigationController presentViewController:fvc animated:YES completion:nil];
}

@end
