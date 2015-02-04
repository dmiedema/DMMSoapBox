//
//  DMMSoapboxPresenter_Tests.m
//  DMMSoapBoxDemo
//
//  Created by Daniel on 2/2/15.
//  Copyright (c) 2015 Daniel Miedema. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <Colours/Colours.h>

#import "DMMTestHelpers.h"
#import "DMMSoapBoxPresenterViewController.h"

@interface DMMSoapboxPresenter_Tests : XCTestCase
@property (strong, nonatomic) DMMSoapBoxPresenterViewController *controller;
@end

@implementation DMMSoapboxPresenter_Tests

- (void)testPresentationControllerCreatesWithDefaults {
    self.controller = [DMMSoapBoxPresenterViewController presentationControllerWithURL:[NSURL URLWithString:@"thisIsAURL"] options:@{kDMMSoapBoxPresenterShowAcceptButton: @NO}];
    
    NSString *controllerURL = self.controller.announcementURL.absoluteString;
    XCTAssertTrue([controllerURL isEqualToString:@"thisIsAURL"], @"%@ != 'thisIsAURL'", controllerURL);
    
    XCTAssertNil(self.controller.acceptBlock, @"Accept block should be nil");
    XCTAssertFalse(self.controller.showAcceptButton, @"Controller should not show accept button");
    XCTAssertNil(self.controller.acceptButtonText, @"%@ should be nil", self.controller.acceptButtonText);
    XCTAssertTrue([[[self.controller valueForKey:@"dismissButton"] backgroundColor] isEqual:[UIColor darkGrayColor]], @"dimiss button color should be dark gray");
}

- (void)testPresentationControllerCreatesWithCustomOptions {
    DMMVoidBlock acceptBlock = ^void(void) {};
    
    NSDictionary *options = @{
                              kDMMSoapBoxPresenterShowAcceptButton: @YES,
                              kDMMSoapBoxPresenterAcceptButtonText: @"test",
                              kDMMSoapBoxPresenterAcceptButtonBlock: acceptBlock,
                              kDMMSoapBoxPresenterDismissButtonColor: [UIColor blueColor],
                              kDMMSoapBoxPresenterAcceptButtonColor: [UIColor magentaColor]
                              };
    
    self.controller = [DMMSoapBoxPresenterViewController presentationControllerWithURL:[NSURL URLWithString:@"thisIsAURL"] options:options];
    
    NSString *controllerURL = self.controller.announcementURL.absoluteString;
    XCTAssertTrue([controllerURL isEqualToString:@"thisIsAURL"], @"%@ != 'thisIsAURL'", controllerURL);
    
    XCTAssertNotNil(self.controller.acceptBlock, @"Accept block should not be nil");
    XCTAssertTrue(self.controller.showAcceptButton, @"Controller should show accept button");
    XCTAssertTrue([self.controller.acceptButtonText isEqualToString:@"test"], @"%@ does not equal 'test'", self.controller.acceptButtonText);
    XCTAssertTrue([self.controller.acceptButtonColor isEqual:[UIColor magentaColor]], @"Accept button color should be magenta");
    XCTAssertTrue([self.controller.dismissButtonColor isEqual:[UIColor blueColor]], @"dimiss button color should be blue");
    
}

- (void)testAcceptButtonTextColorChanges {
    self.controller = [DMMSoapBoxPresenterViewController presentationControllerWithURL:[NSURL URLWithString:@"thisIsAURL"] options:@{kDMMSoapBoxPresenterShowAcceptButton: @YES}];
    
    UIButton *acceptButton = [self.controller valueForKey:@"acceptButton"];
    
    self.controller.acceptButtonColor = [UIColor cyanColor];
    XCTAssertTrue([acceptButton.backgroundColor isEqual:[UIColor cyanColor]], @"Background color should be white");
    XCTAssertTrue([acceptButton.titleLabel.textColor isEqual:[UIColor blackColor]], @"text color should be black");
    
    self.controller.acceptButtonColor = [UIColor purpleColor];
    XCTAssertTrue([acceptButton.backgroundColor isEqual:[UIColor purpleColor]], @"");
    XCTAssertTrue([acceptButton.titleLabel.textColor isEqual:[UIColor whiteColor]], @"");
    
}

- (void)testDismissButtonTextColorChanges {
    self.controller = [DMMSoapBoxPresenterViewController presentationControllerWithURL:[NSURL URLWithString:@"thisIsAURL"] options:@{}];
    
    UIButton *dismissButton = [self.controller valueForKey:@"dismissButton"];
    
    self.controller.dismissButtonColor = [UIColor whiteColor];
    XCTAssertTrue([dismissButton.backgroundColor isEqual:[UIColor whiteColor]], @"Background color should be white");
    XCTAssertTrue([dismissButton.titleLabel.textColor isEqual:[UIColor blackColor]], @"text color should be black");
    
    self.controller.dismissButtonColor = [UIColor blackColor];
    XCTAssertTrue([dismissButton.backgroundColor isEqual:[UIColor blackColor]], @"");
    XCTAssertTrue([dismissButton.titleLabel.textColor isEqual:[UIColor whiteColor]], @"");
}

#pragma mark - Setup
- (void)setUp {
    DMMTests_ResetHHAUserDefaults();
    [super setUp];
}

- (void)tearDown {
    self.controller = nil;
    [super tearDown];
}

@end
