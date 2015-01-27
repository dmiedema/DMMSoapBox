//
//  DMMSoapBoxDownloader.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMSoapBoxDownloader.h"
#import "DMMSoapBoxPresenterViewController.h"
#import "DMMUserDefaults.h"
#import "NSString+DMMMD5.h"
#import "NSUserDefaults+GroundControl.h"

@interface DMMSoapBoxDownloader()

@end

BOOL DMMHasNewSoapboxAnnouncement(void) {
    return ![[DMMUserDefaults lastReadAnnouncementID] isEqualToString:[DMMUserDefaults latestAnnouncementID]];
}

void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults);
void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults) {
    NSSet *keys = [NSSet setWithArray:defaults.allKeys];
    
    BOOL announcementIDSet = NO;
    BOOL announcementURLSet = NO;
    if ([keys containsObject:kDMMSoapBoxLatestAnnouncementIDKey]) {
        [[DMMUserDefaults soapboxDefaults] setObject:defaults[kDMMSoapBoxLatestAnnouncementIDKey] forKey:kDMMSoapBoxDefaultsLatestAnnouncementID];
        announcementIDSet = YES;
    }
    if ([keys containsObject:kDMMSoapBoxLatestAnnouncementURLKey]) {
        [[DMMUserDefaults soapboxDefaults] setObject:defaults[kDMMSoapBoxLatestAnnouncementURLKey] forKey:kDMMSoapBoxLatestAnnouncementIDKey];
        announcementURLSet = YES;
    }
    if (!announcementIDSet || !announcementURLSet) {
        for (NSString *key in keys) {
            if ([key containsString:@"ID"]) {
                [[DMMUserDefaults soapboxDefaults] setObject:defaults[key] forKey:kDMMSoapBoxLatestAnnouncementIDKey];
            } else if ([key containsString:@"URL"]) {
                [[DMMUserDefaults soapboxDefaults] setObject:defaults[key] forKey:kDMMSoapBoxLatestAnnouncementURLKey];
            }
        }
    }
}

@implementation DMMSoapBoxDownloader

+ (void)checkForAnnouncementsWithCompletion:(DMMCompletionBlock)completion {
    NSURL *url = [DMMUserDefaults announcementURL];
    [self downloadAnnouncementsFromURL:url complete:completion];
}

+ (void)downloadAnnouncementsFromURL:(NSURL *)url complete:(DMMCompletionBlock)completion {
    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURL:url success:^(NSDictionary *defaults) {
        DMMSetValuesFromDefaultsIntoSoapBoxDefaults(defaults);
        if (completion) { completion(defaults, nil); }
    } failure:^(NSError *error) {
        if (completion) { completion(nil, error); }
        NSLog(@"[DMMSoapBoxDownloader] ERROR: - %@ %@", error, error.userInfo);
    }];
}

+ (void)registerURLForSoapboxCheck:(NSURL *)url {
    [[DMMUserDefaults soapboxDefaults] setObject:url forKey:kDMMSoapBoxDefaultsAnnouncementURL];
}

@end
