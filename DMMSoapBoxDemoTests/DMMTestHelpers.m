//
//  DMMTestHelpers.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 2/2/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import "DMMTestHelpers.h"
#import "DMMUserDefaults.h"

void DMMTests_ResetHHAUserDefaults(void) {
    NSDictionary *defaults = [[DMMUserDefaults soapboxDefaults] dictionaryRepresentation];
    for (NSString *key in defaults.allKeys) {
        [[DMMUserDefaults soapboxDefaults] removeObjectForKey:key];
    }
}

@implementation DMMTestHelpers

@end
