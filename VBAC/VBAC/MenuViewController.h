//
//  MenuViewController.h
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuDelegate <NSObject>

- (void)goToHome;
- (void)goToSearch;
- (void)goToFavorites;
- (void)goToFAQ;

@end

@interface MenuViewController : UIViewController

//@property (assign, nonatomic) id<MenuDelegate> delegate;
@property double offset;
@property BOOL isDisplayed;

- (IBAction)goToHome:(id)sender;
- (IBAction)goToSearch:(id)sender;
- (IBAction)goToFavorites:(id)sender;
- (IBAction)goToFAQ:(id)sender;

@end
