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
extern NSString * const kDMMSoapBoxLatestAnnouncementIDKey;
extern NSString * const kDMMSoapBoxLatestAnnouncementURLKey;

extern NSString * const kDMMSoapBoxAcceptActionURL;

extern NSString * const kDMMSoapBoxAcceptButtonTitle;
extern NSString * const kDMMSoapBoxShowAcceptButton;

extern NSString * const kDMMSoapBoxAcceptButtonColorHex;
extern NSString * const kDMMSoapBoxDismissButtonColorHex;

@interface DMMUserDefaults : NSObject

+ (NSUserDefaults *)standardUserDefaults;
+ (NSUserDefaults *)soapboxDefaults;

+ (void)markLastAnnouncementAsRead;
+ (NSString *)latestAnnouncementID;
+ (NSString *)lastReadAnnouncementID;
+ (NSURL *)announcementURL;

+ (NSURL *)acceptActionURL;
@end
