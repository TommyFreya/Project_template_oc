//
//  TYVerticalImageTitleButton.m
//  TommyTemplate
//
//  Created by Tommy on 2017/8/3.
//  Copyright © 2017年 Tommy. All rights reserved.
//

#import "TYVerticalImageTitleButton.h"

@implementation TYVerticalImageTitleButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
