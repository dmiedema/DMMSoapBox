//
//  DMMSoapBoxPresenterViewController.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DMMVoidBlock)(void);

@interface DMMSoapBoxPresenterViewController : UIViewController
@property (strong, nonatomic) NSURL *announcementURL;
@property (nonatomic) BOOL showAcceptButton;
@property (copy, nonatomic) NSString *acceptButtonText;
@property (strong, nonatomic) UIColor *acceptButtonColor;
@property (strong, nonatomic) UIColor *dismissButtonColor;
@property (copy, nonatomic) DMMVoidBlock acceptBlock;
@end
