//
//  ViewController.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "ViewController.h"
#import "DMMSoapBoxDownloader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DMMSoapBoxDownloader downloadAnnouncementsFromURL:[NSURL URLWithString:DMMURLForRelativePath(@"/defaults.plist")] complete:^(NSDictionary *defaults, NSError *error) {
        if (!error && defaults) {
            NSLog(@"defaults: %@", defaults);
            [self presentAnnouncementWithDefaults:defaults];
        } else {
            NSLog(@"error: %@ %@", error, error.userInfo);
        }
        
    }];
}


- (void)presentAnnouncementWithDefaults:(NSDictionary *)defaults {
    NSString *url = defaults[kDMMSoapBoxLatestAnnouncementURLKey];
    NSDictionary *options = DMMDefaultsToOptionsDictionary(defaults);
    
    DMMSoapBoxPresenterViewController *soapbox = [DMMSoapBoxPresenterViewController presentationControllerWithURL:[NSURL URLWithString:url] options:options];
    
    [self presentViewController:soapbox animated:YES completion:^{
        
    }];
}
@end
