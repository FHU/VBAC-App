//
//  HospitalsViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalsViewController.h"
#import "HospitalSlideViewController.h"

@interface HospitalsViewController ()

@end

@implementation HospitalsViewController

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
    
//    [self loadTableView];
    [self loadScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)loadTableView {
    //Bring tableView to the front
    [self.view bringSubviewToFront:_tableView];
    [self.view bringSubviewToFront:_mapView];
}

- (void)loadScrollView {
    //Bring scrollView to the front
    [self.view bringSubviewToFront:_scrollView];
    
    int numberOfPages = 10;
    
    _scrollViewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width * numberOfPages, self.view.frame.size.height)];
    [_scrollViewContent setBackgroundColor:[UIColor blackColor]];
    
    int count;
    double position = self.view.frame.size.width;
    
    for (count = 0; count < numberOfPages; count++) {
        //Create a slide
        HospitalSlideViewController *slide = [[HospitalSlideViewController alloc] initWithNibName:@"HospitalSlideViewController" bundle:nil];
        
        //Position the slide after the previous slide
        [slide.view setFrame:CGRectMake(position * count, 0, slide.view.frame.size.width, slide.view.frame.size.height)];
        [slide.view updateConstraints];
        
        //Add the slide to the scrollView
        [_scrollViewContent addSubview:slide.view];
    }
        
    //Set up scroll view using auto layout
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView setContentSize:CGSizeMake(_scrollViewContent.frame.size.width, _scrollView.frame.size.height)];
    
    [_scrollView addSubview:_scrollViewContent];    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    HospitalCell *cell = (HospitalCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        [[NSBundle mainBundle] loadNibNamed:@"HospitalCell" owner:self options:nil];
        cell = [[HospitalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [self hospitalCell];
    }
    
#warning Placeholder data
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */    
}

@end
