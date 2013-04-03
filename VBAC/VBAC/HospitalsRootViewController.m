//
//  HospitalsRootViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalsRootViewController.h"
#import "DetailViewController.h"

@interface HospitalsRootViewController ()

@end

@implementation HospitalsRootViewController

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
    
    //Replace menu button
    UIButton *menu = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [menu setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(openMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    _hospitalsViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menu];
    
    [_hospitalsViewController setDelegate:self];
    
    //Remove search bar background
    for (UIView *subview in _searchBar.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    [_searchBar setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
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

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //Do not allow editing if the left side menu is displayed
    if (_menuViewController.isDisplayed)
        return NO;
    else
        return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    //Search while text is being entered
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {    
    //Dismiss keyboard
    [self.searchBar resignFirstResponder];
    
    //Perform search
    
}

#pragma mark - HospitalsDelegate

- (void)pushDetailForHospital {
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)openFilter {
    if (!_filterViewController) {
        _filterViewController = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    }
    
    [self.navigationController presentViewController:_filterViewController animated:YES completion:nil];
}

@end
