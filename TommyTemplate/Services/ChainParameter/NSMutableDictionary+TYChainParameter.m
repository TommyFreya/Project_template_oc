//
//  NSMutableDictionary+TYChainParameter.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "NSMutableDictionary+TYChainParameter.h"

@implementation NSMutableDictionary (TYChainParameter)

- (NSMutableDictionary *(^)(NSInteger))clientSource {
    return ^id(NSInteger clientSource) {
        [self setObject:@(clientSource) forKey:@"clientSource"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))titleName {
    return ^id(NSString *titleName) {
        [self setObject:titleName forKey:@"titleName"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))urlString {
    return ^id(NSString *urlString) {
        [self setObject:urlString forKey:@"urlString"];
        return self;
    };
}

- (NSMutableDictionary *(^)(id))productModel {
    return ^id(id model) {
        [self setObject:model forKey:@"productModel"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSInteger))page {
    return ^id(NSInteger page) {
        [self setObject:@(page) forKey:@"page"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))keyword {
    return ^id(NSString *keyword) {
        [self setObject:keyword forKey:@"keyword"];
        return self;
    };
}

// 个数
- (NSMutableDictionary *(^)(NSInteger))rows {
    return ^id(NSInteger rows) {
        [self setObject:@(rows) forKey:@"rows"];
        return self;
    };
}
// 排序方式
- (NSMutableDictionary *(^)(NSInteger))sortType {
    return ^id(NSInteger sortType) {
        [self setObject:@(sortType) forKey:@"sortType"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))productId {
    return ^id(NSString *productId) {
        [self setObject:productId forKey:@"productId"];
        return self;
    };
}

- (NSMutableDictionary *(^)(CGFloat))amount {
    return ^id(CGFloat amount) {
        [self setObject:@(amount) forKey:@"amount"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))custName {
    return ^id(NSString *custName) {
        [self setObject:custName forKey:@"custName"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))productName {
    return ^id(NSString *productName) {
        [self setObject:productName forKey:@"productName"];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *))remark {
    return ^id(NSString *remark) {
        [self setObject:remark forKey:@"remark"];
        return self;
    };
}

@end
