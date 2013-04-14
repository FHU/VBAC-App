//
//  FilterViewController.m
//  VBAC
//
//  Created by Richard Simpson on 4/1/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize navigationItem;

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
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [close setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetFilter:(id)sender {
    [_sortOptionSegmentedControl setSelectedSegmentIndex:0];
    [_rateOptionSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [_distanceOptionSegmentedControl setSelectedSegmentIndex:2];
    
    [_delegate resetFilter];
}

- (IBAction)filter:(id)sender {
    int sortOption = _sortOptionSegmentedControl.selectedSegmentIndex;
    double rate = 0.0;
    double distance = -1;
    
    switch (_rateOptionSegmentedControl.selectedSegmentIndex) {
        case 0:
            rate = 10;
            break;
        case 1:
            rate = 15;
            break;
        case 2:
            rate = 25;
            break;
        case 3:
            rate = 50;
            break;
        default:
            break;
    }
    
    switch (_distanceOptionSegmentedControl.selectedSegmentIndex) {
        case 0:
            distance = 10;
            break;
        case 1:
            distance = 25;
            break;
        case 2:
            distance = 50;
            break;
        case 3:
            distance = 100;
            break;
        default:
            break;
    }
    
    //Filter
    [_delegate filterWithSortOption:sortOption Rate:rate Distance:distance];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
