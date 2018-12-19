//
//  LSCategoryBaseCellModel.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryBaseCellModel.h"

@implementation LSCategoryBaseCellModel
- (CGFloat)cellWidth {
    if (_cellWidthZoomEnabled) {
        return _cellWidth * _cellWidthZoomScale;
    }
    return _cellWidth;
}
@end
