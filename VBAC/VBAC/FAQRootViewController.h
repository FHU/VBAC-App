//
//  FAQRootViewController.h
//  VBAC
//
//  Created by Richard Simpson on 4/2/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRevealSideViewController.h"
#import "MenuViewController.h"
#import "FAQViewController.h"

@interface FAQRootViewController : UIViewController

@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet FAQViewController *faqViewController;

- (id)initWithMenu:(MenuViewController *)menu NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (IBAction)openMenu:(id)sender;


@end
