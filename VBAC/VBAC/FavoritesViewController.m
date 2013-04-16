//
//  FavoritesViewController.m
//  VBAC
//
//  Created by Richard Simpson on 4/6/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "FavoritesViewController.h"
#import "HospitalSlideViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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
    
    _hospitalSlides = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)updateScrollView {
    NSMutableArray *slides = [[NSMutableArray alloc] init];
    
    for (Hospital *h in _hospitals) {
        if (h.isFavorite)
            [slides addObject:h];
    }
    
    //If there are no favorites, return
    if (slides.count == 0) {
        return;
    } else {
        [_noHospitalsLabel removeFromSuperview];
    }
    
    int numberOfSlides = slides.count;
    
    _scrollViewContent = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width * numberOfSlides, self.view.frame.size.height)];
    
    //Start by removing all slides
    [_hospitalSlides removeAllObjects];
    
    double position = self.view.frame.size.width;
    
    for (int count = 0; count < numberOfSlides; count++) {
        Hospital *h = [slides objectAtIndex:count];
        
        //Create a slide
        HospitalSlideViewController *slide = [[HospitalSlideViewController alloc] initWithHospital:h NibName:@"HospitalSlideViewController" bundle:nil];
        
        //Position the slide after the previous slide
        [slide.view setFrame:CGRectMake(position * count, 0, slide.view.frame.size.width, self.view.frame.size.height)];
        [slide.view updateConstraints];
        
        //Add the slide to the scrollView
        [_scrollViewContent addSubview:slide.view];
        [_hospitalSlides addObject:slide];        
    }
    
    //Set up scroll view using auto layout
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrollView setContentSize:CGSizeMake(_scrollViewContent.frame.size.width, _scrollViewContent.frame.size.height)];
    
    [_scrollView addSubview:_scrollViewContent];
}

@end
