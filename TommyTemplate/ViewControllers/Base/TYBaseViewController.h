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
- (void)ty_unifyPopForMoreEvent;

@end

@protocol TYBaseViewControllerDelegate <NSObject>

@optional
- (void)ty_configBaseView;
- (void)ty_fetchData;

@end

@interface TYBaseViewController : UIViewController <TYViewControllerPopActionDelegate,TYBaseViewControllerDelegate>

@end
