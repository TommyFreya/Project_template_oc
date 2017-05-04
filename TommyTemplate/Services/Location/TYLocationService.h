//
//  TYLocationService.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TYLocationObject.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kTYLastLocationObject = @"kTYLastLocationObject";

//先判断是否error
typedef void (^LocationBlock)(NSError * _Nullable error,  CLPlacemark * _Nullable placemark);
typedef void (^LocationObjectBlock)(NSError * _Nullable error, TYLocationObject *locationObject);

@interface TYLocationService : NSObject<CLLocationManagerDelegate>

//上一次的定位信息
@property (nonatomic, strong, nullable) TYLocationObject *lastLocationObject;

+ (TYLocationService *)shareLocation;
- (void)getLocation:(LocationBlock _Nullable)locationBlock;
- (void)getLocationObject:(LocationObjectBlock _Nullable)locationObjectBlock;


@end

NS_ASSUME_NONNULL_END

