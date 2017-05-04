//
//  TYDataStoreService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*考虑到移动端的数据,需要存储的并不大*/

typedef NS_ENUM(NSInteger, TYDataStoreTableType) {
    TYDataStoreTableTypeUser = 1,       // 用户表
    TYDataStoreTableTypeProduct = 2,    // 产品表
    // ................  more
};

@class TYKeyValueItem;
@interface TYDataStoreService : NSObject

#pragma mark 存/改
+ (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(TYDataStoreTableType)tableName;
+ (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(TYDataStoreTableType)tableName;
+ (void)putObject:(id)object withId:(NSString *)objectId intoTable:(TYDataStoreTableType)tableName;
/**
 存储对象
 
 @param model <#model description#>
 @param modelId <#modelId description#>
 @param tableName <#tableName description#>
 */
+ (void)putModel:(id)model withId:(NSString *)modelId intoTable:(TYDataStoreTableType)tableName;

#pragma mark 取
+ (NSString *)getStringById:(NSString *)stringId fromTable:(TYDataStoreTableType)tableName;
+ (NSNumber *)getNumberById:(NSString *)numberId fromTable:(TYDataStoreTableType)tableName;
+ (id)getObjectById:(NSString *)objectId fromTable:(TYDataStoreTableType)tableName;
+ (id)getModelById:(NSString *)modelId className:(Class)className fromTable:(TYDataStoreTableType)tableName;
// 获得所有数据
- (NSArray<TYKeyValueItem *> *)getAllItemsFromTable:(TYDataStoreTableType)tableName;

#pragma mark 删
+ (void)deleteObjectById:(NSString *)objectId fromTable:(TYDataStoreTableType)tableName;
+ (void)clearTable:(TYDataStoreTableType)tableName;

@end


@interface TYKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end
