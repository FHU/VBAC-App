//
//  AppDelegate.m
//  VBAC
//
//  Created by Richard Simpson on 3/15/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Customize Navigation Bars
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"barbg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"barbg_flat.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Avenir-Heavy" size:20.0], UITextAttributeFont, nil]];
    
    //Customize Segmented Controls
//    [[UISegmentedControl appearance] setBackgroundImage:[[UIImage imageNamed:@"segment_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UISegmentedControl appearance] setBackgroundImage:[[UIImage imageNamed:@"segment_selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    LoadViewController *viewController = [[LoadViewController alloc] initWithNibName:@"LoadViewController" bundle:nil];
    [viewController.view setFrame:self.window.frame];
    
    //Set up the PPRevealSideViewController as the root view controller of the application
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:viewController];
    [_revealSideViewController setDelegate:self];
    [_revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionNone];
    [_revealSideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionNavigationBar]; //PPRevealSideInteractionContentView default
    
    self.window.rootViewController = _revealSideViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
