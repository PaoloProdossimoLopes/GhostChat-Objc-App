//
//  Snapchat_Clone_App_With_OBJCUITestsLaunchTests.m
//  Snapchat-Clone-App-With-OBJCUITests
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import <XCTest/XCTest.h>

@interface Snapchat_Clone_App_With_OBJCUITestsLaunchTests : XCTestCase

@end

@implementation Snapchat_Clone_App_With_OBJCUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
