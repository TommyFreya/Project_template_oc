//
//  TYImagePickerControllerService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYImagePickerControllerService : NSObject

// 打开相机
+ (void)presentCameraCompletionHandler:(void(^)(UIImage *pikingImage))complete;

// 打开图库
+ (void)presentPhotoLibraryCompletionHandler:(void(^)(UIImage *pikingImage))complete;

// 打开相册
+ (void)presentPhotoAlbumCompletionHandler:(void(^)(UIImage *pikingImage))complete;

@end
