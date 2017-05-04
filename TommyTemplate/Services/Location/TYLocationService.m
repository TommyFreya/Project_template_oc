//
//  TYLocationService.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYLocationService.h"
#import "CLLocation+YCLocation.h"

@interface TYLocationService ()

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, copy) LocationBlock locationBlock;
@property (nonatomic, copy) LocationObjectBlock locationObjectBlock;//坐标

@end

@implementation TYLocationService

+ (TYLocationService *)shareLocation{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        //获取上一次的定位信息
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kTYLastLocationObject];
        if (data) {
            _lastLocationObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
    }
    return self;
}

- (void)getLocation:(LocationBlock)locationBlock {
    _locationBlock = [locationBlock copy];
    [self startLocation];
}

- (void)getLocationObject:(LocationObjectBlock)locationObjectBlock{
    
    _locationObjectBlock = [locationObjectBlock copy];
    
    [self getLocation:^(NSError *error, CLPlacemark *placemark) {
        if (_locationObjectBlock) {
            _locationObjectBlock(error, _lastLocationObject);
        }
    }];
    
}


#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 反向地理编码
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
     {
         CLPlacemark *placemark = [placemarks firstObject];
         
         _lastLocationObject = [[TYLocationObject alloc] initWithCLPlacemark:placemark];
         
         if (_locationBlock) {
             _locationBlock(error, placemark);
         }
         
         if (_lastLocationObject) {
             NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_lastLocationObject];
             [[NSUserDefaults standardUserDefaults] setObject:data forKey:kTYLastLocationObject];
         }
         
     }];
    
    [manager stopUpdatingLocation];
}

-(void)startLocation
{
    if (!_manager) {
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        [_manager requestWhenInUseAuthorization];
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 10.f;
    }
    [_manager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if (_locationBlock) {
        _locationBlock(error, nil);
    }
    [_manager stopUpdatingHeading];
    
}

@end
