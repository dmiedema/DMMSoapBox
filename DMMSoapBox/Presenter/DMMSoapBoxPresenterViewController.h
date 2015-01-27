//
//  DMMSoapBoxPresenterViewController.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
/// typedef to define a block that returns void and takes no arguments
typedef void(^DMMVoidBlock)(void);

/// Key for options dictionary to set if accept button should be shown. Expects a @c BOOL type
extern NSString * const kDMMSoapBoxPresenterShowAcceptButton;
/// Key for options dictionary to set accept button text. Expects a @c NSString type
extern NSString * const kDMMSoapBoxPresenterAcceptButtonText;
/// Key for options dictionary to set accept button color. Expects a @c UIColor type
extern NSString * const kDMMSoapBoxPresenterAcceptButtonColor;
/// Key for options dictionary to set dismiss button color. Expects a @c UIColor type
extern NSString * const kDMMSoapBoxPresenterDismissButtonColor;
/// Key for options dictionary to set accept button accept action. Expects a @c DMMVoidBlock type
extern NSString * const kDMMSoapBoxPresenterAcceptButtonBlock;

@interface DMMSoapBoxPresenterViewController : UIViewController
/// URL to load containing the announcement
@property (strong, nonatomic) NSURL *announcementURL;
/// @c YES if accept button should be shown, @c NO otherwise
@property (nonatomic) BOOL showAcceptButton;
/// Accept button title. Has no effect if @c showAcceptButton is @c NO
@property (copy, nonatomic) NSString *acceptButtonText;
/// Accept button color. Has no effect if @c showAcceptButton is @c NO
@property (strong, nonatomic) UIColor *acceptButtonColor;
/// Dismiss button color.
@property (strong, nonatomic) UIColor *dismissButtonColor;
/// Accept button block. Has no effect if @c showAcceptButton is @c NO
@property (copy, nonatomic) DMMVoidBlock acceptBlock;

/*!
 Create a @c DMMSoapBoxPresenterViewController with specified URL and options alreay applied
 
 @param url     url to load.
 @param options options dictionary to apply values with
 
 @return a @c DMMSoapBoxPresenterViewController with specified URL and options applied
 */
+ (instancetype)presentURL:(NSURL *)url withOptions:(NSDictionary *)options;
@end
