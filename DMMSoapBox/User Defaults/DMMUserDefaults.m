//
//  DMMUserDefaults.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMUserDefaults.h"

////  Defaults Keys
NSString * const kDMMSoapBoxDefaultsBaseURL                  = @"kDMMSoapBoxDefaultsBaseURL";
NSString * const kDMMSoapBoxDefaultsAnnouncementURL          = @"kDMMSoapBoxDefaultsAnnouncementURL";

NSString * const kDMMSoapBoxDefaultsSuite                    = @"kDMMSoapBoxDefaultsSuite";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementID     = @"kDMMSoapBoxDefaultsLatestAnnouncementID";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementRead   = @"kDMMSoapBoxDefaultsLatestAnnouncementRead";

NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementID  = @"kDMMSoapBoxDefaultsLastKnownAnnouncementID";
NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementURL = @"kDMMSoapBoxDefaultsLastKnownAnnouncementURL";


NSString * DMMURLForRelativePath(NSString *path) {
    NSString *base = [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsBaseURL];
    return [NSString stringWithFormat:@"%@%@", base, path];
}

@implementation DMMUserDefaults

#pragma mark - Suites
+ (NSUserDefaults *)standardUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

+ (NSUserDefaults *)soapboxDefaults {
    static NSUserDefaults *defaults = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[NSUserDefaults alloc] initWithSuiteName:kDMMSoapBoxDefaultsSuite];
    });
    return defaults;
}

#pragma mark - Properties
+ (void)markLastAnnouncementAsRead {
    [[DMMUserDefaults soapboxDefaults] setBool:YES forKey:kDMMSoapBoxDefaultsLatestAnnouncementRead];
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxLatestAnnouncementURLKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementURL];
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxLatestAnnouncementIDKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementID];
    [[DMMUserDefaults soapboxDefaults] removeObjectForKey:kDMMSoapBoxAcceptActionURL];
}

+ (void)setBaseURL:(NSString *)baseURL {
    [[DMMUserDefaults soapboxDefaults] setObject:baseURL forKey:kDMMSoapBoxDefaultsBaseURL];
}

+ (NSString *)baseURL {
    return [[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxDefaultsBaseURL];
}

+ (NSString *)latestAnnouncementID {
    return [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsLatestAnnouncementID];
}
+ (NSString *)lastReadAnnouncementID {
    return [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsLastKnownAnnouncementID];
}

+ (NSURL *)announcementURL {
    NSString *announcementPath = [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsAnnouncementURL];
    NSURL *announcementURL = [NSURL URLWithString:announcementPath];
    if (![announcementURL host]) {
        announcementPath = DMMURLForRelativePath(announcementPath);
    }
    return [NSURL URLWithString:announcementPath];
}

+ (NSURL *)acceptActionURL {
    NSString *acceptPath = [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxAcceptActionURL];
    NSURL *acceptURL = [NSURL URLWithString:acceptPath];
    if (![acceptURL host]) {
        acceptPath = DMMURLForRelativePath(acceptPath);
    }
    return [NSURL URLWithString:acceptPath];
}

@end
