//
//  DMMSoapBoxDownloader.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DMMCompletionBlock)(NSDictionary *defaults, NSError *error);

@interface DMMSoapBoxDownloader : NSObject

+ (void)checkForAnnouncements;

+ (void)downloadAnnouncementsFromURL:(NSURL *)url complete:(DMMCompletionBlock)completion;

+ (void)registerURLForSoapboxCheck:(NSURL *)url;

@end
