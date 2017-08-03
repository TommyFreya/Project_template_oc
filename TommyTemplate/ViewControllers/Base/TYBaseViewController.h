//
//  TYBaseViewController.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/4.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TYViewControllerPopActionDelegate <NSObject>

@optional
// 点击返回之前还需要做一些处理操作,但是又不重新创建 lefrBaritemButton, 自己重新写 pop方法 比在这之前加上你想要的操作
- (void)ty_unifyPopForMoreEvent;

@end

@protocol TYBaseViewControllerDelegate <NSObject>

@optional
// 配置 view
- (void)ty_configBaseView;
// 配置 data
- (void)ty_fetchData;

@end

@interface TYBaseViewController : UIViewController <TYViewControllerPopActionDelegate,TYBaseViewControllerDelegate>

@end
