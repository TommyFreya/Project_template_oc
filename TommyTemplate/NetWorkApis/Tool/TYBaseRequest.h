//
//  TYBaseRequest.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface TYBaseRequest : YTKRequest

/**
 request初始化，默认的方式是使用字典，不需要传参直接使用init
 
 @param parame 请求的参数
 @return request
 */
- (id)initWithParame:(NSDictionary *)parame;

/**
 是否隐藏错误提示
 
 @return 默认为No,如果不需要提示，需在子类重写该方法,置为YES
 */
// ................................... 待定,最好设置为属性


/**
 是否需要token参数
 
 @return 默认为YES,如果不需要，需在子类重写该方法，置为NO
 */
// ................................... 待定,最好设置为属性


/**
 是否需要弹出登录视图
 
 @return 默认为YES，如果不需要，需在子类重写该方法，置为NO
 */
// ................................... 待定,最好设置为属性


/**
 是否需要弹出请求非网络原因失败的提示
 
 @return 默认为YES，如果不需要，需在子类重写该方法，置为NO
 */
// ................................... 待定,最好设置为属性


/**
 是否需要loading
 
 @return 默认为NO，如果需要loading，需在dataController中设置该属性为YES
 */
@property (nonatomic, assign,getter=isNeedLoading) BOOL needLoading;

@end
