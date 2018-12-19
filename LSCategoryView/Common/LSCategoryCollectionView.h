//
//  LSCategoryCollectionView.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSCategoryIndicatorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryCollectionView : UICollectionView
@property (nonatomic, strong) NSArray <UIView<LSCategoryIndicatorProtocol> *> *indicators;
@end

NS_ASSUME_NONNULL_END
