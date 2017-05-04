//
//  TYUploadFileRequest.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYUploadFileRequest.h"
#import <AFNetworking.h>

@implementation TYUploadFileRequest

+ (NSURLSessionUploadTask * _Nullable)uploadWithFileData:(NSData * _Nullable)fileData
                                                    name:(NSString * _Nonnull)name
                                                fileName:(NSString * _Nonnull)fileName
                                                mimeType:(NSString * _Nonnull)mimeType
                                                  urlStr:(NSString * _Nonnull)urlStr
                                              parameters:(NSDictionary * _Nullable)parameters
                                                progress:(TYUploadProgressBlock _Nullable)uploadProgress
                                       completionHandler:(TYUploadCompletionHandler _Nullable)handler {
    return [self uploadWithFileData:fileData
                           filePath:nil name:name
                           fileName:fileName
                           mimeType:mimeType
                             urlStr:urlStr
                         parameters:parameters
                           progress:uploadProgress
                  completionHandler:handler];
    
}

+ (NSURLSessionUploadTask * _Nullable)uploadWithFileData:(NSData * _Nullable)fileData
                                                filePath:(NSString * _Nullable)filePath
                                                    name:(NSString * _Nonnull)name
                                                fileName:(NSString * _Nonnull)fileName
                                                mimeType:(NSString * _Nonnull)mimeType
                                                  urlStr:(NSString * _Nonnull)urlStr
                                              parameters:(NSDictionary * _Nullable)parameters
                                                progress:(TYUploadProgressBlock _Nullable)uploadProgress
                                       completionHandler:(TYUploadCompletionHandler _Nullable)handler {
    if (![urlStr hasPrefix:@"/"]) {
        urlStr = [NSString stringWithFormat:@"/%@",urlStr];
    }
    
    urlStr = @".......";
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (filePath) {
            [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name fileName:fileName mimeType:mimeType error:nil];
        } else {
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        }
    } error:nil];
    
    NSURLSessionConfiguration *backgroundSessionconfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    backgroundSessionconfiguration.timeoutIntervalForRequest = 20.0f;
    backgroundSessionconfiguration.timeoutIntervalForResource = 40.0f;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:backgroundSessionconfiguration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:handler];
    
    [uploadTask resume];
    
    return uploadTask;
    
}

@end
