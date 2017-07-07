//
//  AFNet.m
//
//  Created by SKY
//  Copyright © 翊sky. All rights reserved.
//

#import "AFNet.h"
@implementation AFNet

+ (id)shareManager {
    
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain",@"text/javascript",nil];
    });
    return manager;
    
}

+ (void)getRequestHttpURL:(NSString *)url
              completation:(SuccessBlock)success
                   failure:(FailureBlock)failure{

    [self checkNetworkReachabilityStatus];

    AFHTTPSessionManager *manager = [AFNet shareManager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success && responseData) {
            success(responseData);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];

}
+ (void)postRequestHttpURL:(NSString *)url
                  parameter:(id)parameter
               completation:(SuccessBlock)success
                    failure:(FailureBlock)failure{
    
    [self checkNetworkReachabilityStatus];
    
    AFHTTPSessionManager *manager = [AFNet shareManager];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success && responseData) {
            success(responseData);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}

+ (void)postUploadURL:(NSString *)url
           parameters:(NSDictionary *)parameters
             formData:(FormDataBlock)uploadData
             progress:(ProgressBlock)progress
         completation:(SuccessBlock)success
              failure:(FailureBlock)failure{
    
    [self checkNetworkReachabilityStatus];
    
    AFHTTPSessionManager *manager = [AFNet shareManager];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (uploadData) {
            uploadData(formData);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id responseData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success && responseData) {
            success(responseData);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];

}

+ (void)downloadWithRequestURL:(NSString *)URLString
                      progress:(ProgressBlock)progress
                  completation:(DownloadBlock)download {
    
    [self checkNetworkReachabilityStatus];
    
    AFHTTPSessionManager *manager = [AFNet shareManager];
    
    NSURLRequest *request = ({
        
        NSURL *url = [NSURL URLWithString:URLString];
        
        [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    });
    
    [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress);
        }
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //下载到...
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentationDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        //下载完成
        download(response,filePath,error);
        
    }];

}

//检查网络
+ (void)checkNetworkReachabilityStatus{
    
    // 如果要检测网络状态的变化, 必须要用检测管理器的单例startMoitoring
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{//手机网络
                DEBUGLog(@"手机网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{//wifi
                DEBUGLog(@"wifi");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable://没网
            case AFNetworkReachabilityStatusUnknown:{//未知
                DEBUGLog(@"没网");
                return;
                break;
            }
            default:
                break;
        }

    }];
}

@end
