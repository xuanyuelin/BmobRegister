//
//  AFNetWorkingHelper.h
//  DateCorner
//
//  Created by 小儿黑挖土 on 16/12/2.
//  Copyright © 2016年 小儿黑挖土. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "URLMacro.h"
#import <AFNetworking/AFNetworking.h>

@interface AFNetWorkingHelper : NSObject

+(instancetype)defaultHelper;
-(void)sendRequestWithURLString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                         success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache;
-(void)sendRequestWithURLString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                         success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure;
-(void)sendRequestWithURLString:(NSString *)urlString
                         success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache;
-(void)sendRequestWithURLString:(NSString *)urlString
                         success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure;

- (void)uploadWithURLString:(NSString *)urlString
                        data:(NSData *)data
                    success:(void (^)(NSURLResponse *, id))success
                    failure:(void (^)(NSURLResponse *, NSError *))failure;
@end
