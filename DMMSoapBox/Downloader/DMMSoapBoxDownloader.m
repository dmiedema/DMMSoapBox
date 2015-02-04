//
//  DMMSoapBoxDownloader.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMSoapBoxDownloader.h"
#import "NSString+DMMMD5.h"
#import "NSUserDefaults+GroundControl.h"
#import <Colours/Colours.h>

@interface DMMSoapBoxDownloader()

@end

#pragma mark - Private Functions
NSString * DMMUserLibraryPath(void);
NSString * DMMUserLibraryPath(void) {
    return (NSString *)NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}


void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults);
void DMMSetValuesFromDefaultsIntoSoapBoxDefaults(NSDictionary *defaults) {
    NSSet *keys = [NSSet setWithArray:defaults.allKeys];
    
    BOOL announcementIDSet = [keys containsObject:kDMMSoapBoxLatestAnnouncementIDKey];
    BOOL announcementURLSet = [keys containsObject:kDMMSoapBoxLatestAnnouncementURLKey];
    
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

#pragma mark - Public Fuctions
BOOL DMMHasNewSoapboxAnnouncement(void) {
    return ![[DMMUserDefaults lastReadAnnouncementID] isEqualToString:[DMMUserDefaults latestAnnouncementID]];
}

NSDictionary * DMMDefaultsToOptionsDictionary(NSDictionary *defaults) {
    if (!defaults) {
        defaults = [DMMUserDefaults soapboxDefaults].dictionaryRepresentation;
    }
    
    NSMutableDictionary *options = [@{} mutableCopy];
    if (defaults[kDMMSoapBoxAcceptButtonTitle]) {
        options[kDMMSoapBoxPresenterAcceptButtonText] = defaults[kDMMSoapBoxAcceptButtonTitle];
    }
    
    options[kDMMSoapBoxPresenterShowAcceptButton] = defaults[kDMMSoapBoxShowAcceptButton] ?: @NO;
    
    options[kDMMSoapBoxPresenterAcceptButtonColor] = defaults[kDMMSoapBoxAcceptButtonColorHex] ? [UIColor colorFromHexString:defaults[kDMMSoapBoxAcceptButtonColorHex]] : [UIColor whiteColor];
    
    options[kDMMSoapBoxPresenterDismissButtonColor] = defaults[kDMMSoapBoxDismissButtonColorHex] ? [UIColor colorFromHexString:defaults[kDMMSoapBoxDismissButtonColorHex]] : [UIColor darkGrayColor];
    
    return [options copy];
}

static NSString * kDMMSoapboxFileName = @"kDMMSoapboxDictionary.soapbox";
NSString * DMMSoapboxArchivePath(void) {
    NSString *libraryPath = DMMUserLibraryPath();
    return [libraryPath stringByAppendingString:kDMMSoapboxFileName];
}

NSDictionary * DMMSoapboxDictionary(void) {
    return (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithFile:DMMSoapboxArchivePath()];
}

#pragma mark -
@implementation DMMSoapBoxDownloader

+ (void)checkForAnnouncementsWithCompletion:(DMMCompletionBlock)completion {
    NSURL *url = [DMMUserDefaults announcementURL];
    [self downloadAnnouncementsFromURL:url complete:completion];
}

+ (void)downloadAnnouncementsFromURL:(NSURL *)url complete:(DMMCompletionBlock)completion {
    [[DMMUserDefaults soapboxDefaults] registerDefaultsWithURL:url success:^(NSDictionary *defaults) {
        DMMSetValuesFromDefaultsIntoSoapBoxDefaults(defaults);
        if (![NSKeyedArchiver archiveRootObject:defaults toFile:DMMSoapboxArchivePath()]) {
            NSLog(@"DMMSoapboxDownloader [ERROR] - Error archiving `defaults` to library path");
        }
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
