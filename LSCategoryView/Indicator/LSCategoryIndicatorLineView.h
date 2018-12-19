//
//  LSCategoryIndicatorLineView.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCategoryIndicatorProtocol.h"
#import "LSCategoryViewDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryIndicatorLineView : UIView<LSCategoryIndicatorProtocol>

@property (nonatomic, assign) CGFloat verticalMargin;     //垂直方向边距；默认：0

@property (nonatomic, assign) BOOL scrollEnabled;   //手势滚动、点击切换的时候，是否允许滚动，默认YES


@property (nonatomic, assign) CGFloat indicatorLineViewHeight;  //默认：3

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认LSCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius;    //默认LSCategoryViewAutomaticDimension （等于self.indicatorLineViewHeight/2）

@property (nonatomic, strong) UIColor *indicatorLineViewColor;   //默认为[UIColor redColor]

@end

NS_ASSUME_NONNULL_END
