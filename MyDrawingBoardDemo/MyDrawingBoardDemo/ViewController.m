//
//  ViewController.m
//  MyDrawingBoardDemo
//
//  Created by tangchao on 2021/1/27.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import "ViewController.h"
#import "TCDrawingBoardBar.h"
#import "TCDrawingBoardView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<TCDrawingBoardViewDelegate>

@property (nonatomic, strong) TCDrawingBoardBar *toolBar;
@property (nonatomic, strong) TCDrawingBoardView *drawingBoardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     1.能画
     2.能恢复/撤销
     */
    [self.view addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.drawingBoardView];
    self.drawingBoardView.delegate = self;
    [self.drawingBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.toolBar.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    self.drawingBoardView.backgroundColor = [UIColor blackColor];
    
    __weak typeof(self) weakSelf = self;
    self.toolBar.itemClick = ^(int index) {
        if (index == 0) {
            /// 撤销
            if ([weakSelf.drawingBoardView canBackout]) {
                [weakSelf.drawingBoardView backout];
                if ([weakSelf.drawingBoardView canBackout] == NO) {
                    weakSelf.toolBar.preBtn.backgroundColor = [UIColor grayColor];
                }
                
                weakSelf.toolBar.nextBtn.backgroundColor = [UIColor blueColor];
            } else {
                NSLog(@"没有可撤销的操作");
            }
            
        } else if (index == 1) {
            /// 恢复
            if ([weakSelf.drawingBoardView canRecover]) {
                [weakSelf.drawingBoardView recover];
                if ([weakSelf.drawingBoardView canRecover] == NO) {
                    weakSelf.toolBar.nextBtn.backgroundColor = [UIColor grayColor];
                }
                
                weakSelf.toolBar.preBtn.backgroundColor = [UIColor blueColor];
            } else{
                NSLog(@"没有可恢复的操作");
            }
                
        }
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

#pragma mark - TCDrawingBoardViewDelegate
- (void)brushFinish:(TCDrawingBoardView *)drawingBoardView
{
    NSLog(@"%s", __func__);
    if ([drawingBoardView canBackout]) {
        self.toolBar.preBtn.backgroundColor = [UIColor blueColor];
    } else {
        /// 不可撤销,撤销按钮置灰
        self.toolBar.preBtn.backgroundColor = [UIColor grayColor];
    }
    
    if ([drawingBoardView canRecover]) {
        self.toolBar.nextBtn.backgroundColor = [UIColor blueColor];
    } else {
        /// 不可恢复,恢复按钮置灰
        self.toolBar.nextBtn.backgroundColor = [UIColor grayColor];
    }
}

#pragma mark - Getting
- (TCDrawingBoardBar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [TCDrawingBoardBar new];
    }
    return _toolBar;
}
- (TCDrawingBoardView *)drawingBoardView
{
    if (!_drawingBoardView) {
        _drawingBoardView = [TCDrawingBoardView new];
    }
    return _drawingBoardView;
}


@end
