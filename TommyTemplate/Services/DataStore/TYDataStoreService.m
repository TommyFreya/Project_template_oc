//
//  TYDataStoreService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYDataStoreService.h"
#import <YYModel/YYModel.h>
#import <YTKKeyValueStore.h>

@interface TYDataStoreService ()

@property (strong, nonatomic) YTKKeyValueStore *store;

@end

static NSString *const kDatabaseName = @"xxxxxxxx.db";   // 暂定就存一个数据库,不做多数据库

@implementation TYDataStoreService

static TYDataStoreService *instance = nil;
+ (TYDataStoreService *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TYDataStoreService alloc] init];
        instance.store = [[YTKKeyValueStore alloc] initDBWithName:kDatabaseName];
    });
    return instance;
}

// 通过createTableWithName方法，我们可以在打开的数据库中创建表，如果表名已经存在，则会忽略该操作
+ (YTKKeyValueStore *)createStore:(TYDataStoreTableType)tableName {
    YTKKeyValueStore *store = [TYDataStoreService shareInstance].store;
    [store createTableWithName:[TYDataStoreService getTableName:tableName]];
    return store;
}

+ (NSString *)getTableName:(TYDataStoreTableType)tableName {
    NSDictionary *dic = @{@(TYDataStoreTableTypeUser) : @"user_table"};
    return dic[@(tableName)];
}


#pragma mark - 存
+ (void)putObject:(id)object withId:(NSString *)objectId intoTable:(TYDataStoreTableType)tableName {
    [[TYDataStoreService createStore:tableName] putObject:object withId:objectId intoTable:[TYDataStoreService getTableName:tableName]];
}

+ (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(TYDataStoreTableType)tableName {
    [[TYDataStoreService createStore:tableName] putString:string withId:stringId intoTable:[TYDataStoreService getTableName:tableName]];
}

+ (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(TYDataStoreTableType)tableName {
    [[TYDataStoreService createStore:tableName] putNumber:number withId:numberId intoTable:[TYDataStoreService getTableName:tableName]];
}

+ (void)putModel:(id)model withId:(NSString *)modelId intoTable:(TYDataStoreTableType)tableName {
    NSDictionary *json = [model yy_modelToJSONObject];
    [self putObject:json withId:modelId intoTable:tableName];
}


#pragma mark - 取
+ (id)getModelById:(NSString *)modelId className:(Class)className fromTable:(TYDataStoreTableType)tableName {
    id json = [self getObjectById:modelId fromTable:tableName];
    return [className yy_modelWithJSON:json];
}

+ (NSString *)getStringById:(NSString *)stringId fromTable:(TYDataStoreTableType)tableName {
    return [[TYDataStoreService createStore:tableName] getStringById:stringId fromTable:[TYDataStoreService getTableName:tableName]];
}

+ (NSNumber *)getNumberById:(NSString *)numberId fromTable:(TYDataStoreTableType)tableName {
    return [[TYDataStoreService createStore:tableName] getNumberById:numberId fromTable:[TYDataStoreService getTableName:tableName]];
}

+ (id)getObjectById:(NSString *)objectId fromTable:(TYDataStoreTableType)tableName {
    return [[TYDataStoreService createStore:tableName] getObjectById:objectId fromTable:[TYDataStoreService getTableName:tableName]];
}

/*
 // 获得指定key的数据
 - (TYKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
 */

// 获得所有数据
- (NSArray<TYKeyValueItem *> *)getAllItemsFromTable:(TYDataStoreTableType)tableName {
    NSArray *result = [[TYDataStoreService createStore:tableName] getAllItemsFromTable:[TYDataStoreService getTableName:tableName]];
    NSMutableArray *queryDataArray = [NSMutableArray array];
    for (YTKKeyValueItem *item in result) {
        TYKeyValueItem *model = [[TYKeyValueItem alloc] init];
        model.itemId = item.itemId;
        model.itemObject = item.itemObject;
        model.createdTime = item.createdTime;
        [queryDataArray addObject:model];
    }
    return queryDataArray;
}


#pragma mark - 删
+ (void)deleteObjectById:(NSString *)objectId fromTable:(TYDataStoreTableType)tableName {
    [[TYDataStoreService createStore:tableName] deleteObjectById:objectId fromTable:[TYDataStoreService getTableName:tableName]];
}

+ (void)clearTable:(TYDataStoreTableType)tableName {
    [[TYDataStoreService createStore:tableName] clearTable:[TYDataStoreService getTableName:tableName]];
}



@end

@implementation TYKeyValueItem

- (NSString *)description {
    return [NSString stringWithFormat:@"id=%@, value=%@, timeStamp=%@", _itemId, _itemObject, _createdTime];
}

@end


