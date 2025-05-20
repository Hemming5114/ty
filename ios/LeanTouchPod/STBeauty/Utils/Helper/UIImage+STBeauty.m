//
//  UIImage+Additions.m

//
//  Created by bellchen on 15/8/10.
//  Copyright (c) 2015年 wheelswang. All rights reserved.
//

#import "UIImage+STBeauty.h"


@implementation UIImage (STBeauty)

+ (UIImage *)ST_Image:(NSString *)imageName{
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"STBeauty" ofType:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithPath:bundlePath];
    imageName = [imageName stringByAppendingString:@"@2x"];
    NSString *imagePath = [imageBundle pathForResource:imageName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}


@end

 
