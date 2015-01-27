//
//  DMMUserDefaults.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMUserDefaults.h"

////  Defaults Keys
NSString * const kDMMSoapBoxDefaultsAnnouncementURL          = @"kDMMSoapBoxDefaultsAnnouncementURL";

NSString * const kDMMSoapBoxDefaultsSuite                    = @"kDMMSoapBoxDefaultsSuite";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementID     = @"kDMMSoapBoxDefaultsLatestAnnouncementID";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementRead   = @"kDMMSoapBoxDefaultsLatestAnnouncementRead";

NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementID  = @"kDMMSoapBoxDefaultsLastKnownAnnouncementID";
NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementURL = @"kDMMSoapBoxDefaultsLastKnownAnnouncementURL";

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
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxLatestAnnouncementURLKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementID];
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxLatestAnnouncementIDKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementURL];
    [[DMMUserDefaults soapboxDefaults] removeObjectForKey:kDMMSoapBoxAcceptActionURL];
}

+ (NSString *)latestAnnouncementID {
    return [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsLatestAnnouncementID];;
}
+ (NSString *)lastReadAnnouncementID {
    return [[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxDefaultsLastKnownAnnouncementID];
}

+ (NSURL *)announcementURL {
    return [NSURL URLWithString:[[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsAnnouncementURL]];
}

+ (NSURL *)acceptActionURL {
    return [NSURL URLWithString:[[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxAcceptActionURL]];
}

@end
