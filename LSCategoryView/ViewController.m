//
//  ViewController.m
//  LSCategoryView
//
//  Created by lxb on 2018/12/18.
//  Copyright © 2018 lxb. All rights reserved.
//

#import "ViewController.h"
#import "LSCategoryBaseView.h"
#import "LSCategoryTitleView.h"
#import "LSCategoryIndicatorLineView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LSCategoryTitleView *categoryView;
@end

@implementation ViewController

//MARK: - life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupView];
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

//MARK: - private methods
- (void)setupView{
    
    NSArray *titles = @[@"关注", @"发现", @"附近"];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIView *lastView = nil;
    for (int i = 0; i < titles.count; i ++) {
        UIView *subview = [UIView new];
        [containerView addSubview:subview];
        subview.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                             saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                             brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                  alpha:1];
        
        [subview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(containerView);
            make.width.mas_equalTo(CGRectGetWidth([UIScreen mainScreen].bounds));
            if (lastView) {
                make.leading.equalTo(lastView.mas_trailing);
            }else{
                make.leading.equalTo(containerView);
            }
        }];
        lastView = subview;
    }
    
    if (lastView) {
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(lastView.mas_trailing);
        }];
    }
    
    self.categoryView.frame = CGRectMake(0, 6, 200, 32);
    self.navigationItem.titleView = self.categoryView;
    self.categoryView.titles = titles;
}

//MARK: - setter & getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor lightGrayColor];
        scrollView.bounces = NO;
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (LSCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[LSCategoryTitleView alloc] init];
        LSCategoryIndicatorLineView *lineView = [[LSCategoryIndicatorLineView alloc] init];
        lineView.indicatorLineViewHeight = 2;
        _categoryView.indicators = @[lineView];
        
        _categoryView.titleColorGradientEnabled = YES;
        _categoryView.contentScrollView = self.scrollView;
        _categoryView.titleColor = [UIColor lightGrayColor];
        _categoryView.titleSelectedColor = [UIColor blackColor];
    }
    return _categoryView;
}

@end
