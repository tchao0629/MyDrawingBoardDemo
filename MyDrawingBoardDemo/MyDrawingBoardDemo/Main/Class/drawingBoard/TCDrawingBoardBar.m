//
//  TCDrawingBoardBar.m
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCDrawingBoardBar.h"
#import <Masonry.h>

@interface TCDrawingBoardBar ()

@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation TCDrawingBoardBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultValue];
        [self initSubViews];
    }
    return self;
}

- (void)initDefaultValue {
    self.preBtn.layer.cornerRadius = 5;
    self.preBtn.backgroundColor = [UIColor grayColor];
    [self.preBtn setTitle:@"撤销" forState:UIControlStateNormal];
    [self.preBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.backgroundColor = [UIColor grayColor];
    [self.nextBtn setTitle:@"恢复" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initSubViews {
    [self addSubview:self.preBtn];
    [self addSubview:self.nextBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.equalTo(self.nextBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.preBtn);
        make.right.mas_equalTo(-40);
        make.size.equalTo(self.preBtn);
    }];
}

#pragma mark - User Action
- (void)buttonPressed:(UIButton *)sender
{
    if ([sender isEqual:self.preBtn]) {
        /// 撤销
        if (self.itemClick) {
            self.itemClick(0);
        }
    } else if ([sender isEqual:self.nextBtn]) {
        /// 恢复
        if (self.itemClick) {
            self.itemClick(1);
        }
    }
}

#pragma mark - Getting
- (UIButton *)preBtn
{
    if (!_preBtn) {
        _preBtn = [UIButton new];
    }
    return _preBtn;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
    }
    return _nextBtn;
}

@end
