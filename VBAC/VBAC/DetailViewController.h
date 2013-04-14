//
//  DetailViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/30/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hospital.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Hospital *hospital;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UIButton *unfavoriteButton;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
