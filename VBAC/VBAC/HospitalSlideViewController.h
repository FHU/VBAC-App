//
//  HospitalSlideViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/17/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hospital.h"

@interface HospitalSlideViewController : UIViewController

@property (strong, nonatomic) Hospital *hospital;
@property (strong, nonatomic) IBOutlet UIView *panelView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *unfavoriteButton;

- (id)initWithHospital:(Hospital *)hospital NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)toggleFavorites:(id)sender;

@end
