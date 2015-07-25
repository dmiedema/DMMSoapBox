//
//  AppDelegate.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "AppDelegate.h"
#import "DMMUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication * __unused)application didFinishLaunchingWithOptions:(NSDictionary * __unused)launchOptions {
    // Override point for customization after application launch.
    [DMMUserDefaults setBaseURL:@"http://localhost:4567"];
    return YES;
}

@end
