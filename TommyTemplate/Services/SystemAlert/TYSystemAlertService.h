//
//  TYSystemAlertService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TY_ALERT [[TYSystemAlertService alloc] initWithStyle:UIAlertControllerStyleAlert]
#define TY_ACTIONSHEET [[TYSystemAlertService alloc] initWithStyle:UIAlertControllerStyleActionSheet]

NS_ASSUME_NONNULL_BEGIN

typedef void(^TYSystemAlertActionBlock)(UIAlertAction *action);
typedef UIAlertController  * _Nonnull (^TYSystemAlertShowBlock)();
typedef void(^TYSystemAlertConfigurationBlock)(UITextField *textField);

@interface TYSystemAlertService : NSObject

- (instancetype)initWithStyle:(UIAlertControllerStyle)style;

- (TYSystemAlertService *(^)(NSString *))title;
- (TYSystemAlertService *(^)(UIColor *))titleColor;
- (TYSystemAlertService *(^)(NSString *))message;
- (TYSystemAlertService *(^)(UIColor *))messageColor;
- (TYSystemAlertService *(^)(NSTextAlignment))messageAlignment;
- (TYSystemAlertService *(^)(UIColor *))actionUnifyColor;  // 统一设置按钮样式 不写系统默认的蓝色
- (TYSystemAlertService *(^)(UIColor *))actionButtonColor;
- (TYSystemAlertService *(^)(UIColor *))cancelButtonColor;
- (TYSystemAlertService *(^)(NSString *, _Nullable TYSystemAlertActionBlock))action;
- (TYSystemAlertService *(^)(NSString *, _Nullable TYSystemAlertActionBlock))cancelAction;
- (TYSystemAlertService *(^)(TYSystemAlertConfigurationBlock))textField;
- (TYSystemAlertShowBlock)show;

NS_ASSUME_NONNULL_END

@end
