//
//  DMMUserDefaults.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <Foundation/Foundation.h>

////  Defaults Keys
extern NSString * const kDMMSoapBoxDefaultsAnnouncementURL;

extern NSString * const kDMMSoapBoxDefaultsSuite;

extern NSString * const kDMMSoapBoxDefaultsLatestAnnouncementID;

extern NSString * const kDMMSoapBoxDefaultsLatestAnnouncementRead;

////  Plist Keys
static NSString * kDMMSoapBoxLatestAnnouncementIDKey  = @"soapbox_announcement_id";
static NSString * kDMMSoapBoxLatestAnnouncementURLKey = @"soapbox_announcement_url";
static NSString * kDMMSoapBoxAcceptActionURL          = @"soapbox_accept_url";
static NSString * kDMMSoapBoxAcceptButtonTitle        = @"soapbox_accept_title";
static NSString * kDMMSoapBoxShowAcceptButton         = @"soapbox_show_accept_button";
static NSString * kDMMSoapBoxAcceptButtonColorHex     = @"soapbox_accept_color";
static NSString * kDMMSoapBoxDismissButtonColorHex    = @"soapbox_dismiss_color";

@interface DMMUserDefaults : NSObject

+ (NSUserDefaults *)standardUserDefaults;
+ (NSUserDefaults *)soapboxDefaults;

+ (void)markLastAnnouncementAsRead;
+ (NSString *)latestAnnouncementID;
+ (NSString *)lastReadAnnouncementID;
+ (NSURL *)announcementURL;

+ (NSURL *)acceptActionURL;
@end
