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
    
    _searchResults = [[NSMutableArray alloc] init];
    
    if (_loadWithNearby)
        [self performSearchNearby];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    
    [self loadTableView];    
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
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
    
    //Add annotations to map view
    for (Hospital *h in _hospitals) {
        [_mapView addAnnotation:h];
    }
        
    [_tableView reloadData];
    
    //Scroll to the "first" cell
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)loadScrollView {
    //Show the scroll view
    [_scrollView setHidden:NO];
    
    _scrollViewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width * _hospitals.count, self.view.frame.size.height)];
    [_scrollViewContent setBackgroundColor:[UIColor blackColor]];
    
    int count = 0;
    double position = self.view.frame.size.width;
    
    _hospitalSlides = [[NSMutableArray alloc] init];
    
    for (Hospital *h in _hospitals) {
        //Create a slide
        HospitalSlideViewController *slide = [[HospitalSlideViewController alloc] initWithHospital:h NibName:@"HospitalSlideViewController" bundle:nil];
        
        //Position the slide after the previous slide
        [slide.view setFrame:CGRectMake(position * count, 0, slide.view.frame.size.width, self.view.frame.size.height)];
        [slide.view updateConstraints];
        
        //Add the slide to the scrollView
        [_scrollViewContent addSubview:slide.view];
        [_hospitalSlides addObject:slide];
        
        count++;
    }
    
    if (_hospitalSlides.count == 0) {
        return;
    } else {
        [_noHospitalsLabel removeFromSuperview];
    }
    
    //Set up scroll view using auto layout
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView setContentSize:CGSizeMake(_scrollViewContent.frame.size.width, _scrollView.frame.size.height)];
    
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
    
    //Add all hospitals within 50 miles
    for (Hospital *h in _hospitals) {
        if ([h distanceFromLocation:_userLocation] <= 50.0) {
            [_searchResults addObject:h];
        }
    }
    
    if (_searchResults.count == 0)
        NSLog(@"No nearby hospitals on record");
    
    //Reload tableView
    [_tableView reloadData];
}

- (void)performSearchWithText:(NSString *)text {
    //Start by removing everything from the array
    [_searchResults removeAllObjects];
    
    //Add all hospitals that match the search
    if (text.length > 0) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"title contains[cd] %@", text];
        
        _searchResults = [[_hospitals filteredArrayUsingPredicate:pred] mutableCopy];
    }
    
    if (_searchResults.count == 0)
        NSLog(@"No hospitals were found matching the search \"%@\" ", text);
    
    for (Hospital *h in _searchResults) {
        NSLog(@"%@", h.title);
    }
    
    //Reload tableView
    [_tableView reloadData];
}

#pragma mark - FilterDelegate

- (void)resetFilter {
    
}

- (void)filterWithSortOption:(int)option Rate:(double)rate Distance:(double)distance {
    NSMutableArray *filteredSearchResults = [[NSMutableArray alloc] init];
    
    //Add hospitals that match specified rate and distance
    for (Hospital *h in _searchResults) {
        if (h.rate >= rate)
            if ([h distanceFromLocation:_userLocation] <= distance)
                [filteredSearchResults addObject:h];
    }
    
    //Sorting options
    switch (option) {
        case 0:
            //Sort by distance
            break;
        case 1:
            //Sort by rate
            break;
        case 2:
            //Sort by title
            break;
        default:
            break;
    }
    
    //Use the filteredSearchResults array for the tableView
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 15000, 15000);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    
    //Save user location for filtering purposes
    _userLocation = userLocation;
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
        
        //Offset coordinate for portrait view
        CLLocationCoordinate2D offset = h.coordinate;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
        Hospital *h = (Hospital *)view.annotation;
        
        [_delegate pushDetailForHospital:h];
    }
}

/*
- (void)geocode {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@ %@",
                               _address.text,
                               _city.text,
                               _state.text,
                               _zip.text];
    
    [geocoder geocodeAddressString:addressString
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     
                     if (error) {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     
                     if (placemarks && placemarks.count > 0)
                     {
                         CLPlacemark *placemark = placemarks[0];
                         
                         CLLocation *location = placemark.location;
                         _coords = location.coordinate;
                         _coords = location.coordinate;
                         
                         [self showMap];
                     }
                 }];
}


- (void)showMap
{
    NSDictionary *address = @{
                              (NSString *)kABPersonAddressStreetKey: _address.text,
                              (NSString *)kABPersonAddressCityKey: _city.text,
                              (NSString *)kABPersonAddressStateKey: _state.text,
                              (NSString *)kABPersonAddressZIPKey: _zip.text
                              };
    
    MKPlacemark *place = [[MKPlacemark alloc]
                          initWithCoordinate:_coords
                          addressDictionary:address];
    
    MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:place];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving
                              };
    
    [mapItem openInMapsWithLaunchOptions:options];
}
*/

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Add 1 to account for the filter cell at position 0
    return _hospitals.count + 1;
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
        
        Hospital *h = [_hospitals objectAtIndex:indexPath.row - 1]; //Subtract 1 to account for the filter cell
        cell.hospitalLabel.text = h.title;
        cell.distanceLabel.text = [NSString stringWithFormat:@"%.2f miles away", [h distanceFromLocation:_userLocation]];
        cell.percentLabel.text = h.getRate;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Subtract 1 to account for the filter cell
    Hospital *h = [_hospitals objectAtIndex:indexPath.row - 1];
    
    //Tell delegate to push the detail view
    [_delegate pushDetailForHospital:h];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
