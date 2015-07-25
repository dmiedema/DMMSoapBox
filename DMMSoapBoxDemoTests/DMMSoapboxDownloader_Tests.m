//
//  DMMSoapboxDownloader_Tests.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 2/2/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DMMTestHelpers.h"
#import "DMMSoapBoxDownloader.h"

@interface DMMSoapboxDownloader_Tests : XCTestCase

@end

@implementation DMMSoapboxDownloader_Tests

- (void)testDownloadAnnoucementForURL {
    // NSInvocation
}

- (void)testRegisterURLForSoapboxCheck {
    NSString *testURLString = @"test://url";
    [DMMSoapBoxDownloader registerURLForSoapboxCheck:testURLString];
    XCTAssertTrue([testURLString isEqualToString:[DMMUserDefaults announcementURL].absoluteString], @"[DMMUserDefaults announcementURL] '%@' was not equal to '%@'", [DMMUserDefaults announcementURL].absoluteString, testURLString);
}

- (void)testDefaultsToOptionsDictionary {
    [self measureBlock:^{
        // DMMDefaultsToOptionsDictionary(@{})
    }];
}

#pragma mark - Setup
- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

@end
