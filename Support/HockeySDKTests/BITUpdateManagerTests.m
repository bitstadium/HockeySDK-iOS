//
//  BITUpdateManagerTests.m
//  HockeySDK
//
//  Created by Lukas Spieß on 11/01/16.
//
//

#import <XCTest/XCTest.h>

#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import <OCMockitoIOS/OCMockitoIOS.h>
#import <OCMock/OCMock.h>
@import OHHTTPStubs;

#import "HockeySDK.h"
#import "BITUpdateManagerPrivate.h"
#import "BITHockeyBaseManagerPrivate.h"

@interface BITUpdateManagerTests : XCTestCase

@property BITUpdateManager *sut;

@end

@implementation BITUpdateManagerTests

- (void)setUp {
  [super setUp];
  
  self.sut = [[BITUpdateManager alloc] init];
  [self.sut startManager];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testStartManager {
  
}

- (void)testReportErrorWithShowFeedbackDisabled {
  id mockAlertView = OCMPartialMock([UIAlertView alloc]);
  OCMStub([mockAlertView alloc]).andReturn(mockAlertView);
  [[mockAlertView reject] show];
  
  NSError *testError = [NSError errorWithDomain:@"net.hockeyapp.test" code:666 userInfo:nil];
  
  XCTAssertFalse(self.sut.showFeedback);
  
  [self.sut reportError:testError];
  
  XCTAssertFalse(self.sut.showFeedback);
  
  [mockAlertView stopMocking];
}

- (void)testReportErrorWithShowFeedbackEnabled {
  id mockAlertView = OCMPartialMock([UIAlertView alloc]);
  OCMStub([mockAlertView alloc]).andReturn(mockAlertView);
  
  NSError *testError = [NSError errorWithDomain:@"net.hockeyapp.test" code:666 userInfo:nil];
  
  self.sut.showFeedback = YES;
  
  [self.sut reportError:testError];
  
  OCMVerify([mockAlertView show]);
  XCTAssertFalse(self.sut.showFeedback);
  
  [mockAlertView stopMocking];
}

@end
