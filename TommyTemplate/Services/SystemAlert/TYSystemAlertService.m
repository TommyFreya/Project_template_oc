//
//  TYSystemAlertService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYSystemAlertService.h"
#import "TYAlertController.h"
#import "UIViewController+TYTopView.h"

@interface TYSystemAlertService ()

@property (nonatomic, strong) TYAlertController *alertController;

@end

@implementation TYSystemAlertService


- (instancetype)initWithStyle:(UIAlertControllerStyle)style {
    if (self = [super init]) {
        self.alertController = [TYAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:style] ;
        _alertController.titleColor   = [UIColor blackColor];
        _alertController.messageColor = [UIColor blackColor];
        //_alertController.actionColor  = ThemeService.main_color_00;
        //_alertController.cancelColor  = ThemeService.normal_color_10;
        _alertController.messageAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (TYSystemAlertService *(^)(NSString *))title {
    return ^id(NSString * title) {
        self.alertController.title = title;
        return self;
    };
}

- (TYSystemAlertService *(^)(UIColor *))titleColor {
    return ^id(UIColor * titleColor) {
        self.alertController.titleColor = titleColor;
        return self;
    };
}

- (TYSystemAlertService *(^)(NSString *))message {
    return ^id(NSString * message) {
        self.alertController.message = message;
        return self;
    };
}

- (TYSystemAlertService * _Nonnull (^)(UIColor * _Nonnull))messageColor {
    return ^id(UIColor * messageColor) {
        self.alertController.messageColor = messageColor;
        return self;
    };
}

- (TYSystemAlertService * _Nonnull (^)(NSTextAlignment))messageAlignment {
    return ^id(NSTextAlignment messageAlignment) {
        
        self.alertController.messageAlignment = messageAlignment;
        return self;
    };
}

- (TYSystemAlertService * _Nonnull (^)(UIColor * _Nonnull))actionUnifyColor {
    return ^id(UIColor * actionUnifyColor) {
        self.alertController.tintColor = actionUnifyColor;
        return self;
    };
}

- (TYSystemAlertService * _Nonnull (^)(UIColor * _Nonnull))actionButtonColor {
    return ^id(UIColor * actionButtonColor) {
        self.alertController.actionColor = actionButtonColor;
        return self;
    };
}

- (TYSystemAlertService * _Nonnull (^)(UIColor * _Nonnull))cancelButtonColor {
    return ^id(UIColor * cancelButtonColor) {
        self.alertController.cancelColor = cancelButtonColor;
        return self;
    };
}

- (TYSystemAlertService *(^)(NSString * , TYSystemAlertActionBlock))action {
    return ^id(NSString * title, TYSystemAlertActionBlock handler) {
        [self p_addActionWithStyle:UIAlertActionStyleDefault title:title handler:handler];
        return self;
    };
}

- (TYSystemAlertService *(^)(NSString * , TYSystemAlertActionBlock))cancelAction {
    return ^id(NSString * title, TYSystemAlertActionBlock handler) {
        [self p_addActionWithStyle:UIAlertActionStyleCancel title:title handler:handler];
        return self;
    };
}

- (TYSystemAlertService *(^)(TYSystemAlertConfigurationBlock))textField {
    return ^id(TYSystemAlertConfigurationBlock hander) {
        [self.alertController addTextFieldWithConfigurationHandler:hander];
        return self;
    };
}

- (TYSystemAlertShowBlock)show {
    return ^{
        [[UIViewController topViewController] presentViewController:self.alertController animated:YES completion:nil];
        return self.alertController;
    };
}

#pragma mark - Private Methods
- (void)p_addActionWithStyle:(UIAlertActionStyle)style
                       title:(id)title
                     handler:(void (^)(UIAlertAction * action))handler {
    TYAlertAction *action = [TYAlertAction actionWithTitle:title style:style handler:handler];
    [self.alertController addAction:action];
}


@end
