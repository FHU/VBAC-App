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
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    [self loadTableView];
//    [self loadScrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)loadTableView {    
    //Hide the scroll view
    [_scrollView setHidden:YES];
    
    /*
    //Add annotations to map view
    for (Hospital *h in _dataset.hospitals) {
        [_mapView addAnnotation:h];
    }
    */
    
    //Scroll to the "first" cell
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)loadScrollView {
    //Show the scroll view
    [_scrollView setHidden:NO];
        
    int numberOfPages = 10;
    
    _scrollViewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width * numberOfPages, self.view.frame.size.height)];
    [_scrollViewContent setBackgroundColor:[UIColor blackColor]];
    
    int count;
    double position = self.view.frame.size.width;
    
    for (count = 0; count < numberOfPages; count++) {
        //Create a slide
        HospitalSlideViewController *slide = [[HospitalSlideViewController alloc] initWithNibName:@"HospitalSlideViewController" bundle:nil];
        
        //Position the slide after the previous slide
        [slide.view setFrame:CGRectMake(position * count, 0, slide.view.frame.size.width, self.view.frame.size.height)];
        [slide.view updateConstraints];
        
        //Add the slide to the scrollView
        [_scrollViewContent addSubview:slide.view];
    }
        
    //Set up scroll view using auto layout
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView setContentSize:CGSizeMake(_scrollViewContent.frame.size.width, _scrollView.frame.size.height)];
    
    [_scrollView addSubview:_scrollViewContent];    
}

- (IBAction)openFilter:(id)sender {
    [_delegate openFilter];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    } else {
        MKPinAnnotationView *annotationView = nil;
        
        annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"buildingMarker"];
        
        if (nil == annotationView) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"buildingMarker"];
        }
        
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        cell.backgroundColor = [UIColor clearColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
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
    
    //Filter cell
    if (indexPath.row == 0) {
        [cell.hospitalLabel removeFromSuperview];
        [cell.distanceLabel removeFromSuperview];
        [cell.percentLabel removeFromSuperview];
        [cell.divider removeFromSuperview];
    }
    //Other cells
    else {
        [cell.filterButton removeFromSuperview];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate pushDetailForHospital];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
