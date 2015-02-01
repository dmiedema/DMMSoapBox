//
//  DMMSoapBoxDownloader.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <Foundation/Foundation.h>

// Import in .h file so that only one file must be
// imported by the consumer
#import "DMMSoapBoxPresenterViewController.h"
#import "DMMUserDefaults.h"

/*!
 Completion block to when downloading plist completes
 
 @param defaults dictionary downloaded from the endpoint. @c nil if there was an error
 @param error    error received when downloading the plist. @c nil if there was no error
 */
typedef void(^DMMCompletionBlock)(NSDictionary *defaults, NSError *error);

/*!
 Check to see if there is a new announement to show
 
 @return @c YES if there is, @c NO if there is not
 */
BOOL DMMHasNewSoapboxAnnouncement(void);

/*!
 Map values passed from plist keys to options dictionary for announcemnt presenter
 
 @see DMMSoapboxDictionary to load the defaults as they were archived to disk
 
 @param defaults @c NSDictionary of plist key/values from endpoint. If @c nil this will load the @c soapboxDefaults suite as a dictionary and use those values
 @return mapped dictionary with keys set as options for passing into @c DMMSoapboxPresenterViewController
 */
NSDictionary * DMMDefaultsToOptionsDictionary(NSDictionary *defaults);

/*!
 Get the path of the file archvie as a string
 
 @return NSString representation of the file path where the defaults plist is archived to
 */
NSString * DMMSoapboxArchivePath(void);

/*!
 Load the downloaded plist dictionary
 
 @return NSDictionary representation of the plist downloaded from the given endpoint
 */
NSDictionary * DMMSoapboxDictionary(void);

/*!
 */
@interface DMMSoapBoxDownloader : NSObject

/*!
 Check the default URL for any new announcements
 
 @param completion completion block to run upon download finishing
 */
+ (void)checkForAnnouncementsWithCompletion:(DMMCompletionBlock)completion;

/*!
 Download the announcement plist from a url to chek for any new announcements
 
 @param url        @c NSURL to check
 @param completion @c DMMCompletionBlock to execute upon success or failure of download.
 */
+ (void)downloadAnnouncementsFromURL:(NSURL *)url complete:(DMMCompletionBlock)completion;

/*!
 Register a URL to be the default URL to check
 
 @param url url to make the default plist checking endpoint
 */
+ (void)registerURLForSoapboxCheck:(NSURL *)url;

@end
