//
//  LSCategoryBaseCell.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCategoryBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryBaseCell : UICollectionViewCell
@property (nonatomic, strong) LSCategoryBaseCellModel *cellModel;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData:(LSCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
