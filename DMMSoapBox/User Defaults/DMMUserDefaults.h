//
//  DMMUserDefaults.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <Foundation/Foundation.h>

////  Defaults Keys
/// Default Announcement URL to check
extern NSString * const kDMMSoapBoxDefaultsAnnouncementURL;
/// Custom @c NSUserDefaults Suite name
extern NSString * const kDMMSoapBoxDefaultsSuite;
/// Latest announcement ID
extern NSString * const kDMMSoapBoxDefaultsLatestAnnouncementID;
/// Latest announcemnt ID that has been marked as read
extern NSString * const kDMMSoapBoxDefaultsLatestAnnouncementRead;

////  Plist Keys
/// Key to represent the announcement ID. Checked for in the Plist
static NSString * kDMMSoapBoxLatestAnnouncementIDKey  = @"soapbox_announcement_id";
/// Key to represent the announcement ID. Checked for in the Plist
static NSString * kDMMSoapBoxLatestAnnouncementURLKey = @"soapbox_announcement_url";
/// Key to represent the accept action URL to load. Only used if there
/// no accept block specified. Checked for in the Plist
static NSString * kDMMSoapBoxAcceptActionURL          = @"soapbox_accept_url";
/// Key to represent the accept button title. Checked for in the Plist
static NSString * kDMMSoapBoxAcceptButtonTitle        = @"soapbox_accept_title";
/// Key to represent the accept button boolean. Checked for in the Plist
static NSString * kDMMSoapBoxShowAcceptButton         = @"soapbox_show_accept_button";
/// Key to represent the accept button color. Checked for in the Plist
static NSString * kDMMSoapBoxAcceptButtonColorHex     = @"soapbox_accept_color";
/// Key to represent the dimiss button color. Checked for in the Plist
static NSString * kDMMSoapBoxDismissButtonColorHex    = @"soapbox_dismiss_color";

@interface DMMUserDefaults : NSObject

/*!
 Access @c NSUserDefaults_@c standardUserDefaults through a unified interface
 
 @return @c [NSUserDefaults_@c standardUserDefaults]
 */
+ (NSUserDefaults *)standardUserDefaults;

/*!
 Access custom @c NSUserDefaults suite
 
 @return custom @c NSUserDefaults suite
 */
+ (NSUserDefaults *)soapboxDefaults;

/*!
 Mark the last known announcement ID as read
 
 @note stored in @c soapboxDefaults suite
 */
+ (void)markLastAnnouncementAsRead;

/*!
 Retrieve the latest announcement ID we've received
 
 @note stored in @c soapboxDefaults suite
 
 @return Announcement ID as an @c NSString
 */
+ (NSString *)latestAnnouncementID;

/*!
 Retrieve the last announce ID that has been marked as read
 
 @note stored in @c soapboxDefaults suite
 
 @return Most recently read announcement ID as an @c NSString
 */
+ (NSString *)lastReadAnnouncementID;

/*!
 Default URL to check for new announcements at
 
 @note stored in @c soapboxDefaults suite
 
 @return Default URL to check for announcements
 */
+ (NSURL *)announcementURL;

/*!
 URL to call upon @c accept action being selected in presenter
 
 @note stored in @c soapboxDefaults suite
 
 @return URL to have @c sharedApplication call
 */
+ (NSURL *)acceptActionURL;

@end
