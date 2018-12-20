//
//  LSCategoryIndicatorLineView.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryIndicatorLineView.h"
#import "LSCategoryIndicatorParamsModel.h"
#import "LSCategoryFactory.h"

@implementation LSCategoryIndicatorLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollEnabled = YES;
        _verticalMargin = 0;
        _indicatorLineViewHeight = 3;
        _indicatorLineWidth = LSCategoryViewAutomaticDimension;
        _indicatorLineViewColor = [UIColor redColor];
        _indicatorLineViewCornerRadius = LSCategoryViewAutomaticDimension;
    }
    return self;
}

#pragma mark - LSCategoryIndicatorProtocol

- (void)ls_refreshState:(LSCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.indicatorLineViewColor;
    self.layer.cornerRadius = [self getIndicatorLineViewCornerRadius];
    
    CGFloat selectedLineWidth = [self getIndicatorLineViewWidth:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - selectedLineWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorLineViewHeight - self.verticalMargin;
    self.frame = CGRectMake(x, y, selectedLineWidth, self.indicatorLineViewHeight);
}

- (void)ls_contentScrollViewDidScroll:(LSCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getIndicatorLineViewWidth:leftCellFrame];
    
    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getIndicatorLineViewWidth:rightCellFrame];
        
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        
//        targetX = [LSCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
//
//        if (self.indicatorLineWidth == LSCategoryViewAutomaticDimension) {
//            targetWidth = [LSCategoryFactory interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:percent];
//        }
        
        CGFloat offsetX = 20;//x的少量偏移量
        CGFloat maxWidth = rightX - leftX + rightWidth - offsetX*2;
        if (percent <= 0.5) {
            targetX = [LSCategoryFactory interpolationFrom:leftX to:leftX + offsetX percent:percent*2];;
            targetWidth = [LSCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
        }else {
            targetX = [LSCategoryFactory interpolationFrom:(leftX + offsetX) to:rightX percent:(percent - 0.5)*2];
            targetWidth = [LSCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
        }
    }
    
    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)ls_selectedCell:(LSCategoryIndicatorParamsModel *)model {
    CGFloat targetWidth = [self getIndicatorLineViewWidth:model.selectedCellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - targetWidth)/2.0;
    toFrame.size.width = targetWidth;
    
    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        self.frame = toFrame;
    }
}

# pragma mark - Private

- (CGFloat)getIndicatorLineViewCornerRadius
{
    if (self.indicatorLineViewCornerRadius == LSCategoryViewAutomaticDimension) {
        return self.indicatorLineViewHeight/2;
    }
    return self.indicatorLineViewCornerRadius;
}

- (CGFloat)getIndicatorLineViewWidth:(CGRect)cellFrame
{
    if (self.indicatorLineWidth == LSCategoryViewAutomaticDimension) {
        return cellFrame.size.width;
    }
    return self.indicatorLineWidth;
}

@end
