//
//  LSCategoryFactory.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryFactory : NSObject
+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;
+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;
@end

NS_ASSUME_NONNULL_END
