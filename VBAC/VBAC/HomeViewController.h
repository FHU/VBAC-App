//
//  HomeViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeViewDelegate <NSObject>

- (void)openHospitals;
- (void)openFAQ;

@end

@interface HomeViewController : UIViewController

@property (assign, nonatomic) id<HomeViewDelegate> delegate;

- (IBAction)openHospitals:(id)sender;
- (IBAction)openFAQ:(id)sender;

@end
