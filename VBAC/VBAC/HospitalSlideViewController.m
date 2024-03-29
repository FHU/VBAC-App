//
//  HospitalSlideViewController.m
//  VBAC
//
//  Created by Richard Simpson on 3/17/13.
//  Copyright (c) 2013 Bobcat Strike. All rights reserved.
//

#import "HospitalSlideViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>

@interface HospitalSlideViewController ()

@end

@implementation HospitalSlideViewController

- (id)initWithHospital:(Hospital *)hospital NibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _hospital = hospital;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _titleLabel.text = _hospital.title;
    _rateLabel.text = _hospital.getRate;
    
    if ([_hospital.street isEqualToString:@""] || [_hospital.city isEqualToString:@""] || [_hospital.zip isEqualToString:@""])
        _addressLabel.text = @"";
    else
        _addressLabel.text = [NSString stringWithFormat:@"%@\n%@, %@ %@", _hospital.street, _hospital.city, _hospital.state, _hospital.zip];
    
    [_webView.scrollView setScrollEnabled:NO];
    
    [self swapImage];
    [self updateGraph];
    
    [_panelView.layer setCornerRadius:10.0];
        
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateGraph];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom methods

- (void)updateGraph {
    [_activityIndicator startAnimating];
    
    NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"html"];
    NSMutableString *htmlFileString = [NSMutableString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:NULL];
    
    [htmlFileString replaceOccurrencesOfString:@"#year" withString:_hospital.year options:NSCaseInsensitiveSearch range:NSMakeRange(0, htmlFileString.length)];
    
    NSString *vbacRateString = [NSString stringWithFormat:@"%0.1f", _hospital.rate];
    [htmlFileString replaceOccurrencesOfString:@"#VBACrate" withString:vbacRateString options:NSCaseInsensitiveSearch range:NSMakeRange(0, htmlFileString.length)];
    
    //TO DO: Display national average from same year as Hospital's data.
    
    [_webView loadHTMLString:htmlFileString baseURL:NULL];
}

- (IBAction)toggleFavorites:(id)sender {
    if (_hospital.isFavorite)
        _hospital.isFavorite = NO;
    else
        _hospital.isFavorite = YES;
    
    [self swapImage];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_HOSPITAL_DATA" object:nil];
}

- (IBAction)sendTweet:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        NSString *tweetString = @"#VBACfinder";
        NSURL *link = [NSURL URLWithString:@"http://www.fhu.edu"];
        
        [tweetSheet setInitialText:tweetString];
        //        [tweetSheet addURL:link];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"You can't send a tweet. Make sure your device has an internet connection and you have a Twitter account set up."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)shareFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        NSString *fbString = @"";
        NSURL *link = [NSURL URLWithString:@"http://www.fhu.edu"];
        
        [fbSheet setInitialText:fbString];
        //        [fbSheet addURL:link];
        
        [fbSheet setInitialText:fbString];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:@"You can't share on Facebook. Make sure your device has an internet connection and you have a Facebook account set up."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)swapImage {
    if (_hospital.isFavorite)
        [_unfavoriteButton setHidden:NO];
    else
        [_unfavoriteButton setHidden:YES];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_activityIndicator stopAnimating];
}

@end
