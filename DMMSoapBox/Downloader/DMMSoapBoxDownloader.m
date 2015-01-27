//
//  DMMSoapBoxDownloader.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMSoapBoxDownloader.h"
#import "DMMUserDefaults.h"
#import "NSString+DMMMD5.h"
#import "NSUserDefaults+GroundControl.h"

@interface DMMSoapBoxDownloader()

@end

void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults);
void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults) {
    NSSet *keys = [NSSet setWithArray:defaults.allKeys];
    
    BOOL announcementIDSet = NO;
    BOOL announcementURLSet = NO;
    if ([keys containsObject:kDMMSoapBoxDefaultsLatestAnnouncementIDKey]) {
        [[DMMUserDefaults soapboxDefaults] setObject:defaults[kDMMSoapBoxDefaultsLatestAnnouncementIDKey] forKey:kDMMSoapBoxDefaultsLatestAnnouncementID];
        announcementIDSet = YES;
    }
    if ([keys containsObject:kDMMSoapBoxDefaultsLatestAnnouncementURLKey]) {
        [[DMMUserDefaults soapboxDefaults] setObject:defaults[kDMMSoapBoxDefaultsLatestAnnouncementURLKey] forKey:kDMMSoapBoxDefaultsLatestAnnouncementIDKey];
        announcementURLSet = YES;
    }
    if (!announcementIDSet || !announcementURLSet) {
        for (NSString *key in keys) {
            if ([key containsString:@"ID"]) {
                [[DMMUserDefaults soapboxDefaults] setObject:defaults[key] forKey:kDMMSoapBoxDefaultsLatestAnnouncementIDKey];
            } else if ([key containsString:@"URL"]) {
                [[DMMUserDefaults soapboxDefaults] setObject:defaults[key] forKey:kDMMSoapBoxDefaultsLatestAnnouncementURLKey];
            }
        }
    }
}

@implementation DMMSoapBoxDownloader

+ (void)checkForAnnouncements {
    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURL:[DMMUserDefaults announcementURL] success:^(NSDictionary *defaults) {
        DMMSetValuesFromDefaultsIntoSoapBoxDefaults(defaults);
        [self sharedCompletion];
    } failure:^(NSError *error) {
        NSLog(@"[DMMSoapBoxDownloader] ERROR: - %@ %@", error, error.userInfo);
    }];
}

+ (void)downloadAnnouncementsFromURL:(NSURL *)url complete:(DMMCompletionBlock)completion {
    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURL:url success:^(NSDictionary *defaults) {
        completion(defaults, nil);
        DMMSetValuesFromDefaultsIntoSoapBoxDefaults(defaults);
        [self sharedCompletion];
    } failure:^(NSError *error) {
        completion(nil, error);
        NSLog(@"[DMMSoapBoxDownloader] ERROR: - %@ %@", error, error.userInfo);
    }];
}

+ (void)registerURLForSoapboxCheck:(NSURL *)url {
    [[DMMUserDefaults soapboxDefaults] setObject:url forKey:kDMMSoapBoxDefaultsAnnouncementURL];
}

+ (void)sharedCompletion {
    // present soapbox if there is one
}

@end
