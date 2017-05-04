//
//  TYImagePickerControllerService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYImagePickerControllerService.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "UIViewController+TYTopView.h"

static NSString *const TYCameraUnuseful          = @"无法使用相机";
static NSString *const TYPleaseSettingCamera     = @"请在iPhone的""设置-隐私-相机""中允许访问相机";
static NSString *const TYCameraSure              = @"确定";
static NSString *const TYIPhoneSimulator         = @"模拟器中无法打开照相机,请在真机中使用";

static NSString *const TYPhotoUnuseful           = @"无法打开相册";
static NSString *const TYPleaseSettingPhoto      = @"请在iPhone的""设置-隐私-照片""中允许访问相册";
static NSString *const TYPhotoSure              = @"确定";

#define TY_IMAGE_PICKER [TYImagePickerControllerService sharedInstance]


@interface TYImagePickerControllerService ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic,copy) void (^completionHandler)(id obj);


@end

@implementation TYImagePickerControllerService

static id _sharedInstance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

/*
 AVAuthorizationStatusNotDetermined = 0,// 未进行授权选择
 AVAuthorizationStatusRestricted,　　　　// 未授权，且用户无法更新，如家长控制情况下
 AVAuthorizationStatusDenied,　　　　　　 // 用户拒绝App使用
 AVAuthorizationStatusAuthorized,　　　　// 已授权，可使用
 */

+ (void)presentCameraCompletionHandler:(void(^)(UIImage *pikingImage))complete {
    TY_IMAGE_PICKER.completionHandler = complete;
    
    [TY_IMAGE_PICKER requestAccessForMediaCompleteHandler:^(BOOL granted) {
        
        if(granted){
            
            [TY_IMAGE_PICKER openMediaType:UIImagePickerControllerSourceTypeCamera];
        }else{
            
            [TY_IMAGE_PICKER openCameraSystemSetting];
        }
    }];
}

+ (void)presentPhotoLibraryCompletionHandler:(void(^)(UIImage *pikingImage))complete {
    TY_IMAGE_PICKER.completionHandler = complete;
    
    [TY_IMAGE_PICKER requestAccessForMediaCompleteHandler:^(BOOL granted) {
        
        if(granted){
            
            [TY_IMAGE_PICKER openMediaType:UIImagePickerControllerSourceTypePhotoLibrary];
            
        }else{
            
            [TY_IMAGE_PICKER openPhotoSystemSetting];
        }
    }];
}

+ (void)presentPhotoAlbumCompletionHandler:(void(^)(UIImage *pikingImage))complete {
    TY_IMAGE_PICKER.completionHandler = complete;
    
    [TY_IMAGE_PICKER requestAccessForMediaCompleteHandler:^(BOOL granted) {
        
        if(granted){
            
            [TY_IMAGE_PICKER openMediaType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            
        }else{
            
            [TY_IMAGE_PICKER openPhotoSystemSetting];
        }
    }];
}



#pragma mark - Private Methods
- (void)requestAccessForMediaCompleteHandler:(void(^)(BOOL granted))complete {

    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 if(complete)complete(granted);
             });
         }];
    }
    else if ((authStatus == AVAuthorizationStatusRestricted ||
              authStatus == AVAuthorizationStatusDenied) &&
             IOS7_OR_LATER)
    {
        if(complete)complete(NO);
    }
    else
    {
        if(complete)complete(YES);
    }
    
}

- (void)openMediaType:(UIImagePickerControllerSourceType)type {
    
    UIImagePickerControllerSourceType sourceType = type;
    if ([UIImagePickerController isSourceTypeAvailable:type])
    {
        self.imagePickerController.sourceType = sourceType;
        //设置图像选取控制器的类型为静态图像
        self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        
        if(IOS8_OR_LATER){
            self.imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        
        if(type==UIImagePickerControllerSourceTypeCamera){
            
            //self.imagePickerController.allowsEditing = YES;
            //self.imagePickerController.allowsImageEditing =YES;
            //self.imagePickerController.cameraOverlayView = nil;
            //self.imagePickerController.cameraViewTransform = nil;
            
            self.imagePickerController.showsCameraControls = YES;
            self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
            self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        
        
        [[UIViewController topViewController] presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }
    else
    {
        if(type==UIImagePickerControllerSourceTypeCamera){
            
            [self showAlert:TYIPhoneSimulator
                    message:nil
                       sure:TYCameraSure];
        }else{
            
            
            
        }
    }
}

- (void)openCameraSystemSetting{
    [self showAlert:TYCameraUnuseful message:TYPleaseSettingCamera sure:TYCameraSure];
}

- (void)openPhotoSystemSetting{
    [self showAlert:TYPhotoUnuseful message:TYPleaseSettingPhoto sure:TYPhotoSure];
}


#pragma mark Setter & Getter Methods
- (UIImagePickerController *)imagePickerController {
    if (_imagePickerController == nil) {
        _imagePickerController               = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate      = self;
        
/*******************************************根据自身需求是否需要做更改***********************************************************/
//        UINavigationBar  *Bar;
//        UIBarButtonItem  *BarItem;
//        if (IOS9_OR_LATER){
//            
//            Bar       = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//            
//            BarItem   = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        }else{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//            
//            Bar   = [UINavigationBar appearanceWhenContainedIn:[UIImagePickerController class], nil];
//            BarItem   = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
//#pragma clang diagnostic pop
//        }
//        
//        Bar.translucent=NO;
//        Bar.barTintColor = ThemeService.main_color_00;
//        Bar.tintColor    = ThemeService.origin_color_00;
//        [Bar setTitleTextAttributes:
//         @{
//           NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f],
//           NSForegroundColorAttributeName:ThemeService.origin_color_00
//           }];
//        
//        
//        //返回按钮 header-back
//        UIImage *backImage = [UIImage imageNamed:@"header-back"];
//        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        //must both be set if you want to customize the back indicator image.
//        Bar.backIndicatorImage = backImage;
//        Bar.backIndicatorTransitionMaskImage =backImage;
//        //[BarItem setBackButtonBackgroundVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];
//        //[BarItem setBackButtonBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width-1, 0, 0) resizingMode:UIImageResizingModeTile] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//        [BarItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0,-60) forBarMetrics:UIBarMetricsDefault];
//        
//        UIFont  *font = [UIFont boldSystemFontOfSize:15.0f];
//        UIColor *disablecolor = ThemeService.weak_color_11;
//        UIColor *normalcolor  = ThemeService.origin_color_00;
//        [BarItem setTitleTextAttributes:@{
//                                          NSFontAttributeName:font,NSForegroundColorAttributeName:normalcolor}
//                               forState:UIControlStateNormal];
//        [BarItem setTitleTextAttributes:@{
//                                          NSFontAttributeName:font,NSForegroundColorAttributeName:disablecolor}
//                               forState:UIControlStateDisabled];
    }
    return _imagePickerController;
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    /*
     // info dictionary keys
     UIImagePickerControllerMediaType       // an NSString (UTI, i.e. kUTTypeImage)
     UIImagePickerControllerOriginalImage   // a UIImage
     UIImagePickerControllerEditedImage     // a UIImage
     UIImagePickerControllerCropRect        // an NSValue (CGRect)
     UIImagePickerControllerMediaURL        // an NSURL
     UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     UIImagePickerControllerMediaMetadata   // an NSDictionary containing metadata from a captured photo
     UIImagePickerControllerLivePhot        // a PHLivePhoto
     */
    
    WEAK_SELF(self);
    [picker dismissViewControllerAnimated:YES completion:^{
        
        STRONG_SELF(self);
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        //@"public.image"
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
        {
            if(self){
                
                //获取用户编辑之后的图像
                UIImage *editedImage = [info objectForKey:self.imagePickerController.allowsEditing?UIImagePickerControllerEditedImage:UIImagePickerControllerOriginalImage];
                
                //将该图像保存到媒体库中
                //UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
                
                if(self.completionHandler)self.completionHandler(editedImage);
            }
        }
        else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        {
            /*
             //获取视频文件的url
             NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
             //创建ALAssetsLibrary对象并将视频保存到媒体库
             ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
             [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
             if (!error) {
             NSLog(@"captured video saved with no error.");
             }else
             {
             NSLog(@"error occured while saving the video:%@", error);
             }
             }];
             */
            
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    if ([picker isKindOfClass:[UIImagePickerController class]])
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - savePhotoErrorSEL
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    if (!error) {
        NSLog(@"picture saved with no error.");
    }
    else
    {
        NSLog(@"error occured while saving the picture%@", error);
    }
}


- (void)showAlert:(NSString *)title
          message:(NSString *)message
             sure:(NSString *)sure{
    
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    [alert addAction:cancelAction];
    [[UIViewController topViewController] presentViewController:alert animated:YES completion:NULL];
}


@end

