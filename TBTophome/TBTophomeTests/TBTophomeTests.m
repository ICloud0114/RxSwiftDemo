//
//  TBTophomeTests.m
//  TBTophomeTests
//
//  Created by Topband on 2016/12/28.
//  Copyright © 2016年 Topband. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBInfrared.h"

@interface TBTophomeTests : XCTestCase

@end

@implementation TBTophomeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTestExpectation *exp = [self expectationWithDescription:@"测试获取品牌"];
    [TBInfrared getBrandsListWithDeviceType:5 completeHandle:^(NSArray<TBBrandsInfo *> * _Nonnull list, NSError * _Nonnull error) {
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testRids {
    XCTestExpectation *exp = [self expectationWithDescription:@"测试获取Rids"];
    [TBInfrared getRidsWithDeviceId:5 brandId:97 completeHandle:^(NSArray * _Nullable rids, NSError * _Nullable error) {
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];

}

- (void)testAcirModel {
    XCTestExpectation *exp = [self expectationWithDescription:@"测试获取获取空调模式"];
    [TBInfrared getAcirModeWithRid:10727 completeHandle:^(TBAircModeModel * _Nullable models, NSError * _Nullable error) {
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testAcirCompose {
    XCTestExpectation *exp = [self expectationWithDescription:@"测试获取空调红外组合"];
    [TBInfrared getAcirComposeInfraredWithRid:10727 composeParam:@{@"power": @1} completeHandle:^(TBAcirComposeInfraredModel * _Nullable model, NSError * _Nullable error) {
        [exp fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
