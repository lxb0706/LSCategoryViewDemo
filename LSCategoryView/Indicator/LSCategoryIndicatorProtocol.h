//
//  LSCategoryIndicatorLineProtocol.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCategoryIndicatorParamsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LSCategoryIndicatorProtocol <NSObject>

/**
 视图重置状态时调用
 
 param selectedIndex 当前选中的index
 param selectedCellFrame 当前选中的cellFrame
 @param model 数据模型
 */
- (void)ls_refreshState:(LSCategoryIndicatorParamsModel *)model;

/**
 contentScrollView在进行手势滑动时，处理指示器跟随手势变化UI逻辑；
 
 param selectedIndex 当前选中的index
 param leftIndex 正在过渡中的两个cell，相对位置在左边的cell的index
 param leftCellFrame 正在过渡中的两个cell，相对位置在左边的cell的frame
 param rightIndex 正在过渡中的两个cell，相对位置在右边的cell的index
 param rightCellFrame 正在过渡中的两个cell，相对位置在右边的cell的frame
 param percent 过渡百分比
 @param model 数据模型
 */
- (void)ls_contentScrollViewDidScroll:(LSCategoryIndicatorParamsModel *)model;

/**
 点击选中了某一个cell
 
 param lastSelectedIndex 之前选中的index
 param selectedIndex 选中的index
 param selectedCellFrame 选中的cellFrame
 param isClicked YES：点击选中；NO：滚动选中。
 @param model 数据模型
 */
- (void)ls_selectedCell:(LSCategoryIndicatorParamsModel *)model;

@end

NS_ASSUME_NONNULL_END
