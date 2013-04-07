//
//  FavoritesViewController.h
//  VBAC
//
//  Created by Richard Simpson on 4/6/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController

@property (strong, nonatomic) NSArray *hospitals;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIView *scrollViewContent;
@property (strong, nonatomic) NSMutableArray *hospitalSlides;
@property (strong, nonatomic) IBOutlet UILabel *noHospitalsLabel;

@end
