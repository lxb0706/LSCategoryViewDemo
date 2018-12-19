//
//  LSCategoryTitleCell.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "LSCategoryTitleCell.h"
#import "LSCategoryTitleCellModel.h"

@interface LSCategoryTitleCell ()

@end

@implementation LSCategoryTitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.center = self.contentView.center;
}

- (void)reloadData:(LSCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    LSCategoryTitleCellModel *myCellModel = (LSCategoryTitleCellModel *)cellModel;
    
    CGFloat pointSize = myCellModel.titleFont.pointSize;
    UIFontDescriptor *fontDescriptor = myCellModel.titleFont.fontDescriptor;
    
    if (myCellModel.selected) {
        fontDescriptor = myCellModel.titleSelectedFont.fontDescriptor;
        pointSize = myCellModel.titleSelectedFont.pointSize;
    }
    if (myCellModel.titleLabelZoomEnabled) {
        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize*myCellModel.titleLabelZoomScale];
    }else {
        self.titleLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
    }
    
    NSString *titleString = myCellModel.title ? myCellModel.title : @"";
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:titleString];
    if (myCellModel.titleLabelStrokeWidthEnabled) {
        [attriString addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelSelectedStrokeWidth) range:NSMakeRange(0, myCellModel.title.length)];
    }
    
    if (myCellModel.selected) {
        self.titleLabel.textColor = myCellModel.titleSelectedColor;
    }else {
        self.titleLabel.textColor = myCellModel.titleColor;
    }
    
    self.titleLabel.attributedText = attriString;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
