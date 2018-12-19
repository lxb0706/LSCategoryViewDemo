//
//  LSCategoryBaseCellModel.h
//  LSCategoryView
//
//  Created by lxb on 2018/12/19.
//  Copyright © 2018 lxb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LSCategoryBaseCellModel : NSObject
@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) CGFloat cellSpacing;

@property (nonatomic, assign) BOOL cellWidthZoomEnabled;

@property (nonatomic, assign) CGFloat cellWidthZoomScale;

@end

NS_ASSUME_NONNULL_END
