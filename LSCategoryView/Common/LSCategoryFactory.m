//
//  LSCategoryFactory.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryFactory.h"
#import "UIColor+LS.h"

@implementation LSCategoryFactory
+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent{
    CGFloat red = [self interpolationFrom:fromColor.ls_red to:toColor.ls_red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.ls_green to:toColor.ls_green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.ls_blue to:toColor.ls_blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.ls_alpha to:toColor.ls_alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
