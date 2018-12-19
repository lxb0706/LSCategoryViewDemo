//
//  LSCategoryCollectionView.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryCollectionView.h"

@implementation LSCategoryCollectionView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView<LSCategoryIndicatorProtocol> *view in self.indicators) {
        [self sendSubviewToBack:view];
    }
}


@end
