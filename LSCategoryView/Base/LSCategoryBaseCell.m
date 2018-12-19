//
//  LSCategoryBaseCell.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryBaseCell.h"

@implementation LSCategoryBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews
{
    
}

- (void)reloadData:(LSCategoryBaseCellModel *)cellModel {
    self.cellModel = cellModel;
    
}
@end
