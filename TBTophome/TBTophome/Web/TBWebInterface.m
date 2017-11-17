//
//  TBWebInterface.m
//  TBTophome
//
//  Created by Topband on 2017/3/10.
//  Copyright © 2017年 Topband. All rights reserved.
//

#import "TBWebInterface.h"
#import "NSString+Enc.h"

#define Token (@"3030e0c9c713497e9b36eaa5cc7c3615")
#define Host @"https://open.orvibo.com/"

@interface TBWebInterface() <NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation TBWebInterface

- (NSDictionary *)getCommonParams {
    NSString *token = Token;
    long timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger nonce = rand() % 100000;
    NSArray<NSString *> *params = [NSArray<NSString *> arrayWithObjects:token, [@(timestamp) stringValue], [@(nonce) stringValue], nil];
    params = [params sortedArrayUsingSelector:@selector(compare:)];
    NSString *signature = [params componentsJoinedByString:@""];
    signature = [[signature sha1] uppercaseString];
    return @{@"signature": signature,
             @"timestamp": @(timestamp),
             @"nonce": @(nonce),
             @"countryCode": @"CN",
             @"lanCode": @"zh"};
}

- (NSString *)serializationParams:(NSDictionary *)params {
    NSMutableArray<NSString *> *strParams = [NSMutableArray<NSString *> array];
    for (NSString *key in params.allKeys) {
        [strParams addObject:[NSString stringWithFormat:@"%@=%@", key, [params objectForKey:key]]];
    }
    return [strParams componentsJoinedByString:@"&"];
}

- (void)getTaskWithParams:(NSDictionary *)params
                   method:(NSString *)method
        completionHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    NSMutableDictionary *par = [NSMutableDictionary dictionary];
    if (params.count > 0) {
        [par addEntriesFromDictionary:params];
    }
    [par addEntriesFromDictionary:[self getCommonParams]];
    NSString *serialString = [self serializationParams:par];
    NSString *urlString = Host;
    if ([method hasSuffix:@"?"]) {
        urlString = [urlString stringByAppendingString:method];
    } else {
        urlString = [urlString stringByAppendingFormat:@"%@?", method];
    }
    
    urlString = [urlString stringByAppendingString:serialString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 30;
    [self taskWithReqeust:request completionHandler:handler];
}

- (void)taskWithReqeust:(NSURLRequest *)request completionHandler:(void (^)(id _Nullable, NSError * _Nullable))handler {
    [[self.session dataTaskWithRequest:request
                    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if (error == nil) {
                            NSError *parseError = nil;
                            id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                            handler(jsonObject, parseError);
                        } else {
                            handler(nil, error);
                        }
                    }] resume];
}

+ (instancetype)interface {
    return [[TBWebInterface alloc] init];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {
    /*
     <NSURLProtectionSpace: 0x7fef2b686e20>:
     Host:mail.itcast.cn,
     Server:https,
     Auth-Scheme:NSURLAuthenticationMethodServerTrust,
     */
    // 判断是否是信任服务器证书
    if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 告诉服务器，客户端信任证书
        // 创建凭据对象
        NSURLCredential *credntial = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 通过completionHandler告诉服务器信任证书
        completionHandler(NSURLSessionAuthChallengeUseCredential,credntial);
    }
}

#pragma mark - getter setter
- (NSURLSession *)session {
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}
@end
