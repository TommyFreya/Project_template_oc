//
//  TYLocationObject.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLPlacemark.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kLatitude = @"latitude";
static NSString *const kLongitude = @"longitude";

@interface TYLocationObject: NSObject <NSCoding>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;//经纬度 (地球坐标)
@property (nonatomic, assign) CLLocationCoordinate2D marsCoordinate;//经纬度(火星坐标)
@property (nonatomic, assign) CLLocationCoordinate2D baiduCoordinate;//经纬度 (百度坐标)

@property (nonatomic, copy) NSString *fullAddress;//完整的地址  中国重庆市渝中区大溪沟街道人民路101号
@property (nonatomic, copy) NSString *country; //国家
@property (nonatomic, copy) NSString *province; //省
@property (nonatomic, copy) NSString *city; //市
@property (nonatomic, copy) NSString *area; //区
@property (nonatomic, copy) NSString *road; //xx路
@property (nonatomic, copy) NSString *number; //xx号
@property (nonatomic, copy) NSString *roadAndNumber; //= road + Number  例如xx路xx号
@property (nonatomic, copy) NSString *name;//建筑物名称（例如TCL通讯大厦）

@property (nonatomic, strong, nullable) NSDate *date;//定位的时间


/**
 *
 *  CLPlacemark类里面的这些属性说明
 *  administrativeArea      广东省
 *  locality                广州市
 *  subLocality             番禺区/xx县(如有，没有就是nil)
 *  thoroughfare            xx路
 *  subThoroughfare         x号
 *  fullThoroughfare        = thoroughfare + subThoroughfare = xx路x号
 */
- (instancetype)initWithCLPlacemark:(CLPlacemark * _Nullable)placemark;

/**
 *  获取特殊的省市区string (对四个直辖市特殊处理)（当有直辖市的时候去掉第一个市） 如果区不存在例如东莞市，则返回 广东省东莞市--
 *
 *  @param separator 分隔符
 *
 *  @return  例如使用 -当做分隔符，则返回  重庆-重庆市-万胜区
 */
- (NSString *)getSpecialProvinceCityAreaWithSeparator:(NSString * __nullable)separator;

/**
 *  获取省市区string
 *
 *  @param separator 分隔符
 *  @param fillStr 在区为空的情况下的填充字符 例如 emptyFill="--"    广东省东莞市--
 *
 *  @return  例如使用 -当做分隔符，则返回  广东省-深圳市-南山区
 */
- (NSString *)getProvinceCityAreaWithSeparator:(NSString * __nullable)separator emptyFill:(NSString * __nullable)fillStr;

/**
 *  返回完整的地址
 *
 *  @param isIncludeBuildingName YES表示包含建筑物名称（如有）
 *  @return 当isIncludeName=YES的时候 返回 中国广东省深圳市南山区xx街道人民路101号创维大厦
 *          当isIncludeName=NO的时候 返回 中国广东省深圳市南山区xx街道人民路101号
 */
- (NSString *)getFullAddressIncludeBuildingName:(BOOL)isIncludeBuildingName needCountry:(BOOL)needCountry;

/**
 *  获取后面的地址
 *
 *  @param isIncludeBuildingName YES表示包含建筑物名称（如有）
 *  @return 当isIncludeName=YES的时候 返回 xx街道人民路101号创维大厦
 *          当isIncludeName=NO的时候 返回 xx街道人民路101号
 */
- (NSString *)getlastAddressIncludeBuildingName:(BOOL)isIncludeBuildingName;


/**
 返回经度、纬度、省、市、区 字典
 
 @return 字典
 */
- (NSDictionary *)getCoordinateAndProvinceCityArea;

@end

NS_ASSUME_NONNULL_END

