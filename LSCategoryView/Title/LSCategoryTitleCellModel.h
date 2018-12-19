//
//  LSCategoryTitleCellModel.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryTitleCellModel : LSCategoryBaseCellModel
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, assign) BOOL titleLabelZoomEnabled;

@property (nonatomic, assign) CGFloat titleLabelZoomScale;

@property (nonatomic, assign) CGFloat titleLabelStrokeWidthEnabled;

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;
@end

NS_ASSUME_NONNULL_END
