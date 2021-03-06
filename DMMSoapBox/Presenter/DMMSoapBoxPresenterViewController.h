//
//  DMMSoapBoxPresenterViewController.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
/// typedef to define a block that returns void and takes no arguments
NS_ASSUME_NONNULL_BEGIN

typedef void(^DMMVoidBlock)(void);

/// Key for options dictionary to set web configuration options
extern NSString * const kDMMSoapBoxPresenterWebConfiguration;
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

/**
 Create a @c DMMSoapBoxPresenterViewController with specified URL and options alreay applied
 
 @param url     relative url to load. URL must be relative to @c baseURL set on @c DMMUserDefaults
 @param options options dictionary to apply values with
 
 @return a @c DMMSoapBoxPresenterViewController with specified URL and options applied
 */
+ (instancetype)presentationControllerWithURL:(NSURL *)url options:(NSDictionary *)options;

/**
 Present a @c DMMSoapBoxPresenterViewController with specified relative URL on the @c UIApplication keyWindow's rootViewController
 
 @see DMMUserDefaults setBaseURL
 
 @param url     URL relative to @c baseURL on @c DMMUserDefaults to load annoucement from.
 @param options dictionary of options to load and apply to controller
 */
+ (void)presentRelativeURL:(NSString *)url withOptions:(NSDictionary *)options;

/**
 Present a @c DMMSoapBoxPresenterViewController with specified full URL on the @c UIApplication keyWindow's rootViewController
 
 @see DMMUserDefaults setBaseURL
 
 @param url     full URL to load annoucement from.
 @param options dictionary of options to load and apply to controller
 */
+ (void)presentURL:(NSString *)url withOptions:(NSDictionary *)options;

NS_ASSUME_NONNULL_END
@end
