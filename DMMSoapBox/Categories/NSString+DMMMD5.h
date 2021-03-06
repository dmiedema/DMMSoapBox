//
//  NSString+DMMMD5.h
//  DMMSoapBoxDemo
//
//  Created by Daniel on 1/26/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DMMMD5)
/// Get an MD5 representation of the @c NSString Instance
- (NSString * __nonnull)dmm_MD5String;
@end
