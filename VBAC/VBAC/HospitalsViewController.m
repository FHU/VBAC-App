//
//  HospitalsViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalsViewController.h"
#import "HospitalSlideViewController.h"
#import "Hospital.h"
#import "SVProgressHUD.h"

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
    
    _foundLocation = NO;
    
    _searchResults = [[NSMutableArray alloc] init];
    _filteredResults = [[NSMutableArray alloc] init];
    _hospitalSlides = [[NSMutableArray alloc] init];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    [self loadTableView];
}

- (void)viewDidAppear:(BOOL)animated {    
    if (!_foundLocation) {
        if (_loadWithNearby) {
            [SVProgressHUD show];
            [self performSelector:@selector(performSearchNearby) withObject:nil afterDelay:5.0];
        }
    } else {
        [_tableView reloadData];
        if (_filteredResults.count != 0)
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
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
    
    //Add annotations to map view
    [_mapView removeAnnotations:_mapView.annotations];
    
    for (Hospital *h in _searchResults) {
        [_mapView addAnnotation:h];
    }
    
    [_tableView reloadData];
    
    //Scroll to the "first" cell
    if (_foundLocation)
        if (_filteredResults.count != 0)
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)loadScrollView {
    //Show the scroll view
    [_scrollView setHidden:NO];
    
    int numberOfSlides = _filteredResults.count;
    
    _scrollViewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width * numberOfSlides, self.view.frame.size.height)];
    
    //Start by removing all slides
    [_hospitalSlides removeAllObjects];
    
    double position = self.view.frame.size.width;
    
    for (int count = 0; count < numberOfSlides; count++) {
        Hospital *h = [_filteredResults objectAtIndex:count];
        
        //Create a slide
        HospitalSlideViewController *slide = [[HospitalSlideViewController alloc] initWithHospital:h NibName:@"HospitalSlideViewController" bundle:nil];
        
        //Position the slide after the previous slide
        [slide.view setFrame:CGRectMake(position * count, 0, slide.view.frame.size.width, self.view.frame.size.height)];
        [slide.view updateConstraints];
        
        //Add the slide to the scrollView
        [_scrollViewContent addSubview:slide.view];
        [_hospitalSlides addObject:slide];        
    }
    
    if (_hospitalSlides.count == 0) {
        [_noneScrollViewLabel setHidden:NO];
    } else {
        [_noneScrollViewLabel setHidden:YES];
    }
    
    //Set up scroll view using auto layout
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView setContentSize:CGSizeMake(_scrollViewContent.frame.size.width, _scrollViewContent.frame.size.height)];
    
    [_scrollView addSubview:_scrollViewContent];
}

- (IBAction)openFilter:(id)sender {
    if (!_filterViewController) {
        _filterViewController = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
        [_filterViewController setDelegate:self];
    }
    
    [_delegate openFilter:_filterViewController];
}

- (void)performSearchNearby {
    //Start by removing everything from the array
    [_searchResults removeAllObjects];
    
    //Add all hospitals within 100 miles
    for (Hospital *h in _hospitals) {
        double distance = [h distanceFromLocation:_mapView.userLocation];
        if (distance <= 100.0 && distance != 0) {
            [_searchResults addObject:h];
        }
    }
    
    //Filter all hospitals within 50 miles
    [self filterWithSortOption:0 Rate:0 Distance:50];
}

- (void)performSearchWithText:(NSString *)text {
    //Start by removing everything from the array
    [_searchResults removeAllObjects];
    
    //Add all hospitals that match the search
    if (text.length > 0) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"title contains[cd] %@", text];
        
        _searchResults = [[_hospitals filteredArrayUsingPredicate:pred] mutableCopy];
    }
    
    [self filterWithSortOption:0 Rate:0 Distance:999999999];
}

#pragma mark - FilterDelegate

- (void)resetFilter {
    [self filterWithSortOption:0 Rate:0 Distance:999999999];
}

- (void)filterWithSortOption:(int)option Rate:(double)rate Distance:(double)distance {
    //Start by removing everything from the array and removing map annotations
    [_filteredResults removeAllObjects];
    [_mapView removeAnnotations:_mapView.annotations];
    
    //Add hospitals that match specified rate and distance
    for (Hospital *h in _searchResults) {
        if (h.rate >= rate) {
            if ([h distanceFromLocation:_mapView.userLocation] <= distance) {
                [_filteredResults addObject:h];
                [_mapView addAnnotation:h];
            }
        }
    }
    
    //Sorting options
    switch (option) {
        case 0: {
            //Sort by distance, shortest distance first
            [_filteredResults sortUsingComparator: ^(Hospital *h1, Hospital *h2) {
                if ([h1 distanceFromLocation:_mapView.userLocation] < [h2 distanceFromLocation:_mapView.userLocation]) {
                    return (NSComparisonResult)NSOrderedAscending;
                } else if ([h1 distanceFromLocation:_mapView.userLocation] > [h2 distanceFromLocation:_mapView.userLocation]) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            break;
        }
        case 1: {
            //Sort by rate, highest rate first
            [_filteredResults sortUsingComparator: ^(Hospital *h1, Hospital *h2) {
                if (h1.rate > h2.rate) {
                    return (NSComparisonResult)NSOrderedAscending;
                } else if (h1.rate < h2.rate) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            break;
        }
        case 2: {
            //Sort by title, alphabetical
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
            [_filteredResults sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            break;
        }
        default:
            break;
    }
    
    [_tableView reloadData];
    
    if (_filteredResults.count == 0) {
        [_noneTableViewLabel setHidden:NO];
        [SVProgressHUD dismiss];
    } else {
        [self zoomToFitAnnotations];
        [_noneTableViewLabel setHidden:YES];
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)zoomToFitAnnotations {
    //http://stackoverflow.com/questions/4169459/whats-the-best-way-to-zoom-out-and-fit-all-annotations-in-mapkit
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for (Hospital *h in _mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, h.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, h.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, h.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, h.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [_mapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!_foundLocation) {
        double miles = 50;
        double meters = miles * 1609.34;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, meters, meters);
        [mapView setRegion:[mapView regionThatFits:region] animated:YES];
            
        [_tableView reloadData];
        _foundLocation = YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    } else {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"buildingMarker"];
        
        if (!annotationView)
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"buildingMarker"];
        
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
        Hospital *h = (Hospital *)view.annotation;
        
        //Find index of selected hospital
        int index = 0;
        
        for (int count = 0; count < _filteredResults.count; count++) {
            Hospital *h2 = [_filteredResults objectAtIndex:count];
            if ([h.title isEqualToString:h2.title])
                index = count;
        }
        
        //Scroll to the selected hospital
        if (index != 0)
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index+1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
        Hospital *h = (Hospital *)view.annotation;
        
        [_delegate pushDetailForHospital:h];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Add 1 to account for the filter cell at position 0
    return _filteredResults.count + 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0)
        cell.backgroundColor = [UIColor clearColor];
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == ((NSIndexPath *)tableView.indexPathsForVisibleRows.lastObject).row){
        if (indexPath.row > 1) {
            //End of loading
            [SVProgressHUD dismiss];            
        }
    }
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
        
        Hospital *h = [_filteredResults objectAtIndex:indexPath.row - 1]; //Subtract 1 to account for the filter cell
        
        cell.hospitalLabel.text = h.title;
        cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f miles away", [h distanceFromLocation:_mapView.userLocation]];
        cell.percentLabel.text = h.getRate;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Subtract 1 to account for the filter cell
    Hospital *h = [_filteredResults objectAtIndex:indexPath.row - 1];
    
    //Tell delegate to push the detail view
    [_delegate pushDetailForHospital:h];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
