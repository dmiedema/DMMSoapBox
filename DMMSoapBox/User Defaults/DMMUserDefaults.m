//
//  DMMUserDefaults.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMUserDefaults.h"

NSString * const kDMMSoapBoxDefaultsSuite = @"com.danielmiedema.kDMMSoapBoxDefaultsSuite";

NSString * const kDMMSoapBoxDefaultsAnnouncementURL = @"kDMMSoapBoxDefaultsAnnouncementURL";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementID = @"kDMMSoapBoxDefaultsLatestAnnouncementID";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementIDKey = @"soap_box_announcement_id";

NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementID = @"kDMMSoapBoxDefaultsLastKnownAnnouncementID";
NSString * const kDMMSoapBoxDefaultsLastKnownAnnouncementURL = @"kDMMSoapBoxDefaultsLastKnownAnnouncementURL";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementRead = @"kDMMSoapBoxDefaultsLatestAnnouncementRead";

NSString * const kDMMSoapBoxDefaultsLatestAnnouncementURLKey = @"soap_box_announcement_url";

NSString * const kDMMSoapBoxDefaultsAcceptActionURL = @"kDMMSoapBoxDefaultsAcceptActionURL";

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
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxDefaultsLatestAnnouncementURLKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementID];
    [[DMMUserDefaults soapboxDefaults] setObject:[[DMMUserDefaults soapboxDefaults] objectForKey:kDMMSoapBoxDefaultsLatestAnnouncementIDKey] forKey:kDMMSoapBoxDefaultsLastKnownAnnouncementURL];
    [[DMMUserDefaults soapboxDefaults] removeObjectForKey:kDMMSoapBoxDefaultsAcceptActionURL];
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
    return [NSURL URLWithString:[[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsAcceptActionURL]];
}

@end
