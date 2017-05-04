//
//  TYWeakScriptMessageHandler.h
//  TommyTemplate
//
//  Created by Tommy on 2017/5/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface TYWeakScriptMessageHandler : NSObject <WKScriptMessageHandler>

@property (nonatomic, weak) id scriptMessageHandler;

@end
