//
//  TYUploadFileRequest.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 因为 YTK 不支持 进度返回 so 单独写一个上传的请求类
 */

typedef void(^TYUploadProgressBlock)(NSProgress * _Nonnull uploadProgress);
typedef void(^TYUploadCompletionHandler)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error);


@interface TYUploadFileRequest : NSObject

+ (NSURLSessionUploadTask * _Nullable)uploadWithFileData:(NSData * _Nullable)fileData
                                                    name:(NSString * _Nonnull)name
                                                fileName:(NSString * _Nonnull)fileName
                                                mimeType:(NSString * _Nonnull)mimeType
                                                  urlStr:(NSString * _Nonnull)urlStr
                                              parameters:(NSDictionary * _Nullable)parameters
                                                progress:(TYUploadProgressBlock _Nullable)uploadProgress
                                       completionHandler:(TYUploadCompletionHandler _Nullable)handler;

/**
 *  文件上传接口
 *
 *  @param fileData       文件data
 *  @param filePath       文件存储在沙盒路径
 *  @param name           key
 *  @param fileName       文件名
 *  @param mimeType       文件类型例如 image/jpeg
 *  @param urlStr         url
 *  @param parameters     body
 *  @param uploadProgress 进度回调
 *  @param handler        处理成功/失败
 *
 *  @return NSURLSessionUploadTask
 */
+ (NSURLSessionUploadTask * _Nullable)uploadWithFileData:(NSData * _Nullable)fileData
                                                filePath:(NSString * _Nullable)filePath
                                                    name:(NSString * _Nonnull)name
                                                fileName:(NSString * _Nonnull)fileName
                                                mimeType:(NSString * _Nonnull)mimeType
                                                  urlStr:(NSString * _Nonnull)urlStr
                                              parameters:(NSDictionary * _Nullable)parameters
                                                progress:(TYUploadProgressBlock _Nullable)uploadProgress
                                       completionHandler:(TYUploadCompletionHandler _Nullable)handler;

@end
