//
//  LSCategoryTitleView.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryTitleView.h"
#import "LSCategoryFactory.h"
#import "LSCategoryViewDefines.h"

@interface LSCategoryTitleView ()

@end

@implementation LSCategoryTitleView

- (void)initializeData{
    [super initializeData];
    
    _titleLabelZoomEnabled = NO;
    _titleLabelZoomScale = 1.2;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
    _titleLabelZoomScrollGradientEnabled = YES;
    _titleLabelStrokeWidthEnabled = NO;
    _titleLabelSelectedStrokeWidth = -3;
}

- (void)setIndicators:(NSArray<UIView<LSCategoryIndicatorProtocol> *> *)indicators {
    for (UIView *component in self.indicators) {
        //先移除之前的component
        [component removeFromSuperview];
    }
    _indicators = indicators;
    
    for (UIView *component in self.indicators) {
        [self.collectionView addSubview:component];
    }
    
    self.collectionView.indicators = indicators;
}

- (UIFont *)titleSelectedFont {
    if (_titleSelectedFont != nil) {
        return _titleSelectedFont;
    }
    return self.titleFont;
}

#pragma mark - Override

- (Class)preferredCellClass {
    return [LSCategoryTitleCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        LSCategoryTitleCellModel *cellModel = [[LSCategoryTitleCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(LSCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(LSCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    LSCategoryTitleCellModel *myUnselectedCellModel = (LSCategoryTitleCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleColor = self.titleColor;
    myUnselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myUnselectedCellModel.titleLabelZoomScale = 1.0;
    myUnselectedCellModel.titleLabelSelectedStrokeWidth = 0;
    
    LSCategoryTitleCellModel *myselectedCellModel = (LSCategoryTitleCellModel *)selectedCellModel;
    myselectedCellModel.titleColor = self.titleColor;
    myselectedCellModel.titleSelectedColor = self.titleSelectedColor;
    myselectedCellModel.titleLabelZoomScale = self.titleLabelZoomScale;
    myselectedCellModel.titleLabelSelectedStrokeWidth = self.titleLabelSelectedStrokeWidth;
}

/**
 当contentScrollView滚动时候，处理跟随手势的过渡效果。
 根据cellModel的左右位置、是否选中、ratio进行过滤数据计算。
 
 @param leftCellModel 左边的cellModel
 @param rightCellModel 右边的cellModel
 @param ratio 从左往右方向计算的百分比
 */
- (void)refreshLeftCellModel:(LSCategoryBaseCellModel *)leftCellModel rightCellModel:(LSCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    
    LSCategoryTitleCellModel *leftModel = (LSCategoryTitleCellModel *)leftCellModel;
    LSCategoryTitleCellModel *rightModel = (LSCategoryTitleCellModel *)rightCellModel;
    
    if (self.titleLabelZoomEnabled && self.titleLabelZoomScrollGradientEnabled) {
        leftModel.titleLabelZoomScale = [LSCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
        rightModel.titleLabelZoomScale = [LSCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
    }
    
    if (self.titleLabelStrokeWidthEnabled) {
        leftModel.titleLabelSelectedStrokeWidth = [LSCategoryFactory interpolationFrom:self.titleLabelSelectedStrokeWidth to:0 percent:ratio];
        rightModel.titleLabelSelectedStrokeWidth = [LSCategoryFactory interpolationFrom:0 to:self.titleLabelSelectedStrokeWidth percent:ratio];
    }
    
    if (self.titleColorGradientEnabled) {
        //处理颜色渐变
        if (leftModel.selected) {
            leftModel.titleSelectedColor = [LSCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleColor = self.titleColor;
        }else {
            leftModel.titleColor = [LSCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
            leftModel.titleSelectedColor = self.titleSelectedColor;
        }
        if (rightModel.selected) {
            rightModel.titleSelectedColor = [LSCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleColor = self.titleColor;
        }else {
            rightModel.titleColor = [LSCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
            rightModel.titleSelectedColor = self.titleSelectedColor;
        }
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == LSCategoryViewAutomaticDimension) {
        return ceilf([self.titles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(LSCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    LSCategoryTitleCellModel *model = (LSCategoryTitleCellModel *)cellModel;
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.title = self.titles[index];
    model.titleLabelZoomScale = 1.0;
    model.titleLabelStrokeWidthEnabled = self.titleLabelStrokeWidthEnabled;
    model.titleLabelSelectedStrokeWidth = 0;
    if (index == self.selectedIndex) {
        model.titleLabelZoomScale = self.titleLabelZoomScale;
        model.titleLabelSelectedStrokeWidth = self.titleLabelSelectedStrokeWidth;
    }
}


- (void)refreshState {
    [super refreshState];
    
    CGRect selectedCellFrame = CGRectZero;
    LSCategoryBaseCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        LSCategoryBaseCellModel *cellModel = (LSCategoryBaseCellModel *)self.dataSource[i];
        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            cellModel.selected = YES;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }
    
    for (UIView<LSCategoryIndicatorProtocol> *component in self.indicators) {
        if (self.dataSource.count <= 0) {
            component.hidden = YES;
        }else {
            component.hidden = NO;
            LSCategoryIndicatorParamsModel *indicatorParamsModel = [[LSCategoryIndicatorParamsModel alloc] init];
            indicatorParamsModel.selectedIndex = self.selectedIndex;
            indicatorParamsModel.selectedCellFrame = selectedCellFrame;
            [component ls_refreshState:indicatorParamsModel];
        }
    }
}


- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    if (baseIndex + 1 >= self.dataSource.count) {
        //右边越界了，不需要处理
        return;
    }
    CGFloat remainderRatio = ratio - baseIndex;
    
    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = [self getTargetCellFrame:baseIndex + 1];
    
    LSCategoryIndicatorParamsModel *indicatorParamsModel = [[LSCategoryIndicatorParamsModel alloc] init];
    indicatorParamsModel.selectedIndex = self.selectedIndex;
    indicatorParamsModel.leftIndex = baseIndex;
    indicatorParamsModel.leftCellFrame = leftCellFrame;
    indicatorParamsModel.rightIndex = baseIndex + 1;
    indicatorParamsModel.rightCellFrame = rightCellFrame;
    indicatorParamsModel.percent = remainderRatio;
    if (remainderRatio == 0) {
        for (UIView<LSCategoryIndicatorProtocol> *component in self.indicators) {
            [component ls_contentScrollViewDidScroll:indicatorParamsModel];
        }
    }else {
        LSCategoryBaseCellModel *leftCellModel = (LSCategoryBaseCellModel *)self.dataSource[baseIndex];
        LSCategoryBaseCellModel *rightCellModel = (LSCategoryBaseCellModel *)self.dataSource[baseIndex + 1];
        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];
        
        for (UIView<LSCategoryIndicatorProtocol> *component in self.indicators) {
            [component ls_contentScrollViewDidScroll:indicatorParamsModel];
        }
        
        LSCategoryBaseCell *leftCell = (LSCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadData:leftCellModel];
        LSCategoryBaseCell *rightCell = (LSCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadData:rightCellModel];
    }
}

- (BOOL)selectCellAtIndex:(NSInteger)index isClicked:(BOOL)isClicked {
    NSInteger lastSelectedIndex = self.selectedIndex;
    BOOL result = [super selectCellAtIndex:index isClicked:isClicked];
    if (!result) {
        return NO;
    }
    
    CGRect clickedCellFrame = [self getTargetCellFrame:index];
    
    LSCategoryBaseCellModel *selectedCellModel = (LSCategoryBaseCellModel *)self.dataSource[index];
    for (UIView<LSCategoryIndicatorProtocol> *component in self.indicators) {
        LSCategoryIndicatorParamsModel *indicatorParamsModel = [[LSCategoryIndicatorParamsModel alloc] init];
        indicatorParamsModel.lastSelectedIndex = lastSelectedIndex;
        indicatorParamsModel.selectedIndex = index;
        indicatorParamsModel.selectedCellFrame = clickedCellFrame;
        indicatorParamsModel.isClicked = isClicked;
        [component ls_selectedCell:indicatorParamsModel];
    }
    
    LSCategoryBaseCell *selectedCell = (LSCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadData:selectedCellModel];
    
    return YES;
}
@end
