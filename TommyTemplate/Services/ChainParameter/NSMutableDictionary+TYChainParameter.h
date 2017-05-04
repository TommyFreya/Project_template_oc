//
//  NSMutableDictionary+TYChainParameter.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TY_P [NSMutableDictionary dictionary]

/**
 链式拼接字典----可以适用于 网络请求参数/vc跳转参数
 */
@interface NSMutableDictionary (TYChainParameter)

#pragma mark - ***************************************** 其他 *****************************************************
// 来源  1：android;2: iOS
- (NSMutableDictionary *(^)(NSInteger))clientSource;


#pragma mark - ***************************************** H5 Link *****************************************************
- (NSMutableDictionary *(^)(NSString *))titleName;
- (NSMutableDictionary *(^)(NSString *))urlString;


#pragma mark - ***************************************** Product *****************************************************
// 产品 Model
- (NSMutableDictionary *(^)(id))productModel;
// 页数
- (NSMutableDictionary *(^)(NSInteger))page;
// 搜索关键字
- (NSMutableDictionary *(^)(NSString *))keyword;
// 个数
- (NSMutableDictionary *(^)(NSInteger))rows;
// 排序方式
- (NSMutableDictionary *(^)(NSInteger))sortType;
// 产品 ID
- (NSMutableDictionary *(^)(NSString *))productId;
// 预约金额
- (NSMutableDictionary *(^)(CGFloat))amount;
// 客户名称
- (NSMutableDictionary *(^)(NSString *))custName;
// 产品名称
- (NSMutableDictionary *(^)(NSString *))productName;
// 备注
- (NSMutableDictionary *(^)(NSString *))remark;

@end











