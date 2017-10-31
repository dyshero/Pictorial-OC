//
//  AFNet.h
//
//  Created by SKY
//  Copyright © 翊sky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef void(^SuccessBlock)(id object);//成功回传数据
typedef void(^FailureBlock)(NSError *error);//失败回传数据
typedef void(^ProgressBlock)(NSProgress *progress);//上传或下载进度
typedef void(^FormDataBlock)(id<AFMultipartFormData> formData);
typedef void(^DownloadBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);//下载回传结果

@interface AFNet : NSObject

/**
 *  Request network data by get way
 *
 *  @param url          Request url
 *  @param success      A block When requset success, do other work in it
 *  @param failure      A block When requset fail, deal with it when error
 */
+ (void)getRequestHttpURL:(NSString *)url
              completation:(SuccessBlock)success
                   failure:(FailureBlock)failure;

/**
 *  Request network data by get way
 *
 *  @param url          Request url
 *  @param parameter    Requset data maybe use parameter
 *  @param success      A block When requset success, do other work in it
 *  @param failure      A block When requset fail, deal with it when error
 */
+ (void)postRequestHttpURL:(NSString *)url
                  parameter:(id)parameter
               completation:(SuccessBlock)success
                    failure:(FailureBlock)failure;

/**
 *  Commit Data and receive response from server
 *
 *  @param url        A server url
 *  @param parameters Upload data maybe use parameter
 *  @param uploadData A block When upload data
 *  @param progress   A block to show upload progress
 *  @param success    A block When upload success, and receive response data, do other work in it
 *  @param failure    A block When upload fail, deal with it when error
 */
+ (void)postUploadURL:(NSString *)url
           parameters:(NSDictionary *)parameters
             formData:(FormDataBlock)uploadData
             progress:(ProgressBlock)progress
         completation:(SuccessBlock)success
              failure:(FailureBlock)failure;

/**
 *  Download data
 *
 *  @param URLString Download url
 *  @param progress  A block to show download progress
 *  @param download  Result when download success or fail
 */
+ (void)downloadWithRequestURL:(NSString *)URLString
                      progress:(ProgressBlock)progress
                  completation:(DownloadBlock)download;



/**
 Request network data by get way
 @param url A server url
 @param parameters parameter
 @return signal
 */
+ (RACSignal *)getRequestHttpURL:(NSString *)url parameters:(NSDictionary *)parameters;

@end
