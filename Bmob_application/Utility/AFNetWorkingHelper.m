
//  AFNetWorkingHelper.m
//  DateCorner
//
//  Created by 小儿黑挖土 on 16/12/2.
//  Copyright © 2016年 小儿黑挖土. All rights reserved.


#import "AFNetWorkingHelper.h"

static AFNetWorkingHelper *_instance = nil;

@interface AFNetWorkingHelper ()

@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end
@implementation AFNetWorkingHelper

+(instancetype) defaultHelper{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _instance = [[super allocWithZone:NULL] init];
        [_instance initialization];
    });
    return _instance;
}
//重写alloc，copy的调用方法，instanc只初始化一次，实现单例
+(id)allocWithZone:(struct _NSZone *)zone{
    return [AFNetWorkingHelper defaultHelper];
}
-(id)copyWithZone:(struct _NSZone *)zone{
    return [AFNetWorkingHelper defaultHelper];
}
#pragma mark HTTP
-(void)sendRequestWithURLString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                         success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache{
//    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    if(useCache){
        _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }else{
        _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    if(parameters != nil){//post
        [_manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            @try{
                success(task,responseObject);
            }@catch(NSException *exception){
                NSLog(@"[%@] throws exception:%@",NSStringFromSelector(_cmd),exception);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @try{
                failure(task,error);
            }@catch(NSException *exception){
                NSLog(@"[%@] throws exception:%@",NSStringFromSelector(_cmd),exception);
            }
        }];
    }else{//get
        [_manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            @try{
                success(task,responseObject);
            }@catch(NSException *exception){
                NSLog(@"[%@] throws exception:%@",NSStringFromSelector(_cmd),exception);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @try{
                failure(task,error);
            }@catch(NSException *exception){
                NSLog(@"[%@] throws exception:%@",NSStringFromSelector(_cmd),exception);
            }
        }];
    }
}
-(void)sendRequestWithURLString:(NSString *)urlString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure{
    [self sendRequestWithURLString:urlString parameters:parameters success:success failure:failure cache:NO];
}
-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure
                          cache:(BOOL)useCache{
    [self sendRequestWithURLString:urlString parameters:nil success:success failure:failure cache:useCache];
}
-(void)sendRequestWithURLString:(NSString *)urlString
                        success:(void (^)(NSURLSessionDataTask *,id))success
                        failure:(void (^)(NSURLSessionDataTask *,NSError *))failure{
    [self sendRequestWithURLString:urlString parameters:nil success:success failure:failure cache:NO];
}
-(void)uploadWithURLString:(NSString *)urlString
                      data:(NSData *)data
                    success:(void (^)(NSURLResponse *,id))success
                   failure:(void (^)(NSURLResponse *,NSError *))failure{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"b21fbd9b0ce4879dc618f6f685c223e0" forHTTPHeaderField:@"X-Bmob-Application-Id"];
    [request addValue:@"8f397fe28f5e02d316d9af109b3fcdc9" forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
    [request addValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];

    NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        @try{
            if(error != nil){
                /*error	NSError *	domain: @"com.alamofire.error.serialization.response" - code: 18446744073709550605	0x0000600000440a50*/
                failure(response,error);
            }else{
                success(response,responseObject);
            }
        }@catch(NSException *exception){
            NSLog(@"throw exception:%@",exception);
        }
    }];
    [task resume];
}
#pragma mark private
-(void)initialization{
    self.manager = [AFHTTPSessionManager manager];
}
@end



