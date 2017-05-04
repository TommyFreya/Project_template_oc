//
//  TYRegExUtil.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYRegExUtil.h"

@implementation TYRegExUtil

+ (BOOL)checkMobileNumber:(NSString *)mobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8] 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188
     * 联通：130 131 132 145 155 156 171 175 176 185 186
     * 电信：133 1349 153 173 177 180 181 189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183、184,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130 131 132 145 155 156 171 175 176 185 186    新增（171、175）
     17         */
    NSString * CU = @"^1(3[0-2]|45|5[56]|7[156]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133 1349 153 173 177 180 181 189  新增（173）
     22         */
    NSString * CT = @"^1((33|53|7[37]|8[019])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * other = @"^1(70[0-9])\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestot = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", other];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES)
        ||([regextestot evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)mobileOperatorsWithMobileNumber:(NSString *)mobileNumber {
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183、184,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|78|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130 131 132 145 155 156 171 175 176 185 186    新增（171、175）
     17         */
    NSString * CU = @"^1(3[0-2]|45|5[56]|7[156]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133 1349 153 173 177 180 181 189  新增（173）
     22         */
    NSString * CT = @"^1((33|53|7[37]|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestcm evaluateWithObject:mobileNumber]) {
        return @"中国移动";
    } else if ([regextestcu evaluateWithObject:mobileNumber]) {
        return @"中国联通";
    } else if ([regextestct evaluateWithObject:mobileNumber]) {
        return @"中国电信";
    } else {
        return @"未知";
    }
}


+ (BOOL)checkIsBankCard:(NSString *)cardNo {
    
    NSInteger oddsum = 0;     //奇数求和
    NSInteger evensum = 0;    //偶数求和
    NSInteger allsum = 0;
    NSInteger cardNoLength = (NSInteger)[cardNo length];
    NSInteger lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (NSInteger i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        NSInteger tmpVal = [tmpString integerValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}

+ (BOOL)checkPassword:(NSString *)password {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    //NSString *passWordRegex = @"^[0-9a-zA-Z_]{6,18}$";                               //  字母或数字或 _
    //NSString *passWordRegex = @"^[^ ]{6,18}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

+ (BOOL)checkEmail:(NSString *)email {
    NSString *emailRegex   = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
