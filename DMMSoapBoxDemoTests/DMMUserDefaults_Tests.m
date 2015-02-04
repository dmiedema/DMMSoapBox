//
//  DMMUserDefaults_Tests.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 2/2/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "DMMTestHelpers.h"
#import "DMMUserDefaults.h"

@interface DMMUserDefaults_Tests : XCTestCase

@end

@implementation DMMUserDefaults_Tests

- (void)testSettingBaseURL {
    NSString *baseURL = @"baseURL";
    [DMMUserDefaults setBaseURL:baseURL];
    
    NSString *defaultsURL = [[DMMUserDefaults soapboxDefaults] stringForKey:kDMMSoapBoxDefaultsBaseURL];
    XCTAssertTrue([baseURL isEqualToString:defaultsURL], @"'%@' should equal '%@'", baseURL, defaultsURL);
}

- (void)testMarksLastAnnouncementAsRead {
    [[DMMUserDefaults soapboxDefaults] setObject:@"1" forKey:kDMMSoapBoxLatestAnnouncementURLKey];
    
    XCTAssertTrue([@"1" isEqualToString:[DMMUserDefaults latestAnnouncementID]], @"Latest announcement ID should be '1'. Instead was %@", [DMMUserDefaults latestAnnouncementID]);
    XCTAssertNil([DMMUserDefaults lastReadAnnouncementID], @"There should be no 'lastReadAnnouncementID'");
    
    [DMMUserDefaults markLastAnnouncementAsRead];
    
    NSString *lastID = [DMMUserDefaults lastReadAnnouncementID];
    XCTAssertTrue( lastID && [@"1" isEqualToString:lastID], @"Last read ID should be '1' and should be set. Instead was %@", lastID);
}

- (void)testAnnouncementURLReturnsCorrectly {
    [DMMUserDefaults soapboxDefaults];
    
}

- (void)testAcceptActionURLReturnsCorrectly {
    [DMMUserDefaults soapboxDefaults];
    
}

#pragma mark -
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Setup
- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    DMMTests_ResetHHAUserDefaults();
    [super tearDown];
}

@end
