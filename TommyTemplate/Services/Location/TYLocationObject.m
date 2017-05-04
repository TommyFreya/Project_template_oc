//
//  TYLocationObject.m
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYLocationObject.h"
#import "CLLocation+YCLocation.h"

@implementation TYLocationObject

- (instancetype)init{
    return [self initWithCLPlacemark:nil];
}

- (instancetype)initWithCLPlacemark:(CLPlacemark * _Nullable)placemark {
    
    self = [super init];
    if (self) {
        [self setup:placemark];
    }
    return self;
}

- (void)setup:(CLPlacemark * _Nullable)placemark{
    
    NSArray *full = placemark.addressDictionary[@"FormattedAddressLines"];
    _fullAddress = [self correctString:[full firstObject]];
    
    _country = [self correctString:placemark.country];
    _province = [self correctString:placemark.administrativeArea];
    _city = [self correctString:placemark.locality];
    _area = [self correctString:placemark.subLocality];
    _road = [self correctString:placemark.thoroughfare];
    _number = [self correctString:placemark.subThoroughfare];
    
    NSString *rn = placemark.addressDictionary[@"Street"];
    _roadAndNumber = [self correctString:rn];
    
    _name = [self correctString:placemark.name];
    
    _date = placemark.location.timestamp;
    
    
    //坐标转换
    
    //地球坐标
    _coordinate = placemark.location.coordinate;
    
    //火星坐标
    CLLocation *marsLocation = [placemark.location locationMarsFromEarth];
    _marsCoordinate = marsLocation.coordinate;
    
    //百度坐标
    CLLocation *baiduLocation = [marsLocation locationBaiduFromMars];
    _baiduCoordinate = baiduLocation.coordinate;
}


//返回特殊的省市区(对四个直辖市特殊处理)  重庆 重庆市 万盛区
- (NSString *)getSpecialProvinceCityAreaWithSeparator:(NSString *)separator{
    NSString *province = _province;
    if ([_province hasSuffix:@"市"]) {
        province = [_province substringToIndex:_province.length - 1];
    }
    return [self getShengShiQuWithProvince:province city:_city area:_area separator:separator emptyFill:@"--"];
}

//返回省市区
- (NSString *)getProvinceCityAreaWithSeparator:(NSString *)separator emptyFill:(NSString *)fillStr{
    return [self getShengShiQuWithProvince:_province city:_city area:_area separator:separator emptyFill:fillStr];
}

- (NSString *)getShengShiQuWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area separator:(NSString *)separator emptyFill:(NSString *)fillStr {
    separator = [self correctString:separator];
    fillStr = [self correctString:fillStr];
    province = [self correctString:province emptyFill:fillStr];
    city = [self correctString:city emptyFill:fillStr];
    area = [self correctString:area emptyFill:fillStr];
    return [[NSString stringWithFormat:@"%@%@%@%@%@", province, separator, city, separator, area] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//返回完整的地址(是否包括建筑物名称)
- (NSString *)getFullAddressIncludeBuildingName:(BOOL)isIncludeBuildingName needCountry:(BOOL)needCountry{
    
    NSString *full = _fullAddress;
    if (isIncludeBuildingName && _name && ![_name isEqualToString:full]) {
        full = [full stringByAppendingString:_name];
    }
    if (!needCountry) {
        //去掉国家
        NSRange range = [full rangeOfString:_country];
        if (range.location != NSNotFound) {
            full = [full substringFromIndex:range.location+range.length];
        }
    }
    
    return full;
}


//返回后面的地址(是否包括建筑物名称)
- (NSString *)getlastAddressIncludeBuildingName:(BOOL)isIncludeBuildingName{
    NSString *lastStr = _roadAndNumber;
    
    NSString *rangeStr = _area;
    if (_area.length == 0) {
        rangeStr = _city;
    }
    
    NSRange range = [_fullAddress rangeOfString:rangeStr];
    if (range.location != NSNotFound) {
        lastStr = [_fullAddress substringFromIndex:range.location+range.length];
    }
    
    if (isIncludeBuildingName && _name && ![_name isEqualToString:_fullAddress]) {
        lastStr = [lastStr stringByAppendingString:_name];
    }
    
    return lastStr;
}


- (NSDictionary *)getCoordinateAndProvinceCityArea {
    
    NSString *longitude = [NSString stringWithFormat:@"%lf", _baiduCoordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%lf", _baiduCoordinate.latitude];
    
    NSString *str = [self getSpecialProvinceCityAreaWithSeparator:@"-"];
    NSArray *componts = [str componentsSeparatedByString:@"-"];
    
    NSString *province = componts[0];
    NSString *city = componts[1];
    NSString *district = componts[2];
    
    NSDictionary *dict = @{kLongitude: longitude,
                           kLatitude: latitude,
                           @"province": province,
                           @"city": city,
                           @"district": district};
    
    return dict;
}


//防止nil,避免stringWithFormat出问题
//如果是nil用""代替
- (NSString *)correctString:(NSString *)str{
    return [self correctString:str emptyFill:@""];
}

- (NSString *)correctString:(NSString *)str emptyFill:(NSString *)fillStr{
    if (!str || str.length == 0) {
        return fillStr ? fillStr : @"";
    }
    return str;
}



#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_fullAddress forKey:@"fullAddress"];
    [aCoder encodeObject:_country forKey:@"country"];
    [aCoder encodeObject:_province forKey:@"province"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_area forKey:@"area"];
    [aCoder encodeObject:_road forKey:@"road"];
    [aCoder encodeObject:_number forKey:@"number"];
    [aCoder encodeObject:_roadAndNumber forKey:@"roadAndNumber"];
    [aCoder encodeObject:_name forKey:@"name"];
    
    [aCoder encodeObject:_date forKey:@"date"];
    
    [aCoder encodeDouble:_coordinate.latitude forKey:@"coordinate.latitude"];
    [aCoder encodeDouble:_coordinate.longitude forKey:@"coordinate.longitude"];
    
    [aCoder encodeDouble:_marsCoordinate.latitude forKey:@"marsCoordinate.latitude"];
    [aCoder encodeDouble:_marsCoordinate.longitude forKey:@"marsCoordinate.longitude"];
    
    [aCoder encodeDouble:_baiduCoordinate.latitude forKey:@"baiduCoordinate.latitude"];
    [aCoder encodeDouble:_baiduCoordinate.longitude forKey:@"baiduCoordinate.longitude"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        
        _fullAddress = [aDecoder decodeObjectForKey:@"fullAddress"];
        _country = [aDecoder decodeObjectForKey:@"country"];
        _province = [aDecoder decodeObjectForKey:@"province"];
        _city = [aDecoder decodeObjectForKey:@"city"];
        _area = [aDecoder decodeObjectForKey:@"area"];
        _road = [aDecoder decodeObjectForKey:@"road"];
        _number = [aDecoder decodeObjectForKey:@"number"];
        _roadAndNumber = [aDecoder decodeObjectForKey:@"roadAndNumber"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        
        _date = [aDecoder decodeObjectForKey:@"date"];
        
        
        double coordinateLatitude = [aDecoder decodeDoubleForKey:@"coordinate.latitude"];
        double coordinateLongitude = [aDecoder decodeDoubleForKey:@"coordinate.longitude"];
        _coordinate = CLLocationCoordinate2DMake(coordinateLatitude, coordinateLongitude);
        
        double marsCoordinateLatitude = [aDecoder decodeDoubleForKey:@"marsCoordinate.latitude"];
        double marsCoordinateLongitude = [aDecoder decodeDoubleForKey:@"marsCoordinate.longitude"];
        _marsCoordinate = CLLocationCoordinate2DMake(marsCoordinateLatitude, marsCoordinateLongitude);
        
        double baiduCoordinateLatitude = [aDecoder decodeDoubleForKey:@"baiduCoordinate.latitude"];
        double baiduCoordinateLongitude = [aDecoder decodeDoubleForKey:@"baiduCoordinate.longitude"];
        _baiduCoordinate = CLLocationCoordinate2DMake(baiduCoordinateLatitude, baiduCoordinateLongitude);
    }
    
    return self;
    
}

@end

