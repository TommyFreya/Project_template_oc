//
//  TYRegExUtil.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYRegExUtil : NSObject

// 正则匹配手机号码
+ (BOOL)checkMobileNumber:(NSString *)mobileNumber;

// 根据手机号返回运营商
+ (NSString *)mobileOperatorsWithMobileNumber:(NSString *)mobileNumber;

// 校验银行卡合法性算法
+ (BOOL)checkIsBankCard:(NSString *)cardNo;

// 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;

//邮箱
+ (BOOL)checkEmail:(NSString *)email;

@end
