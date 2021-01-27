//
//  TCDrawingBoardView.m
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCDrawingBoardView.h"
#import "TCStack.h"

/** 画笔 */
@interface TCBrush : NSObject

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, assign) CGMutablePathRef path;

@end

@implementation TCBrush

- (void)dealloc
{
    CGPathRelease(_path);
    self.layer = nil;
    self.path = NULL;
}

- (instancetype)init
{
    if (self = [super init]) {
        /// 创建画笔 CAShapeLayer->CALayer->NSObject
        _layer = [CAShapeLayer layer];
        /// 画笔颜色
        _layer.strokeColor = [UIColor whiteColor].CGColor;
        _layer.fillColor = [UIColor clearColor].CGColor;
        /// 画笔线条的宽度
        _layer.lineWidth = 1;
        
        _layer.lineJoin = kCALineJoinRound;
        _layer.lineCap = kCALineCapRound;
        
        _path = CGPathCreateMutable();
    }
    return self;
}

/** 是否是有效的画笔 只是点击,没有移动,则认为为无效的画笔 */
- (BOOL)isValid
{
    CGRect brushBox = CGPathGetBoundingBox(self.path);
    if (CGSizeEqualToSize(brushBox.size, CGSizeZero)) {
//        NSLog(@"%@", NSStringFromCGRect(brushBox));
    /// 不是有效的画笔
        return NO;
    }
    
    return YES;
}

/** 将画笔移动到point位置 */
- (void)moveToPoint:(CGPoint)point {
    CGPathMoveToPoint(self.path, nil, point.x, point.y);
}

/** 做画 */
- (void)brush:(CGPoint)point;
{
    CGPathAddLineToPoint(self.path, nil, point.x, point.y);
    self.layer.path = self.path;
}

@end

@interface TCDrawingBoardView ()
{
    /** 画的内容栈 */
    TCStack<TCBrush *> *_strokeStack;
    /** 恢复撤销的内容栈 */
    TCStack<TCBrush *> *_recoverStack;
    
    /** 当前画笔 */
    TCBrush *_currentBrush;
}

@end

@implementation TCDrawingBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _strokeStack = [TCStack new];
        _recoverStack = [TCStack new];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s", __FUNCTION__);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    /// 创建画笔
    TCBrush *brush = [TCBrush new];
    [self.layer addSublayer:brush.layer];
    /// 将画笔移动到需要作画的point
    [brush moveToPoint:point];
    
    _currentBrush = brush;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s", __FUNCTION__);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    /// 作画
    [_currentBrush brush:point];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s", __FUNCTION__);
    if (![_currentBrush isValid]) {
        /// 不是有效的画笔
        [_currentBrush.layer removeFromSuperlayer];
        _currentBrush = nil;
        return ;
    }
    
    if (_currentBrush) {
        /// 将当前画笔入栈
        [_strokeStack push:_currentBrush];
        /// 将恢复撤销栈清空
        [_recoverStack clear];
        
        if ([self.delegate respondsToSelector:@selector(brushFinish:)]) {
            [self.delegate performSelector:@selector(brushFinish:) withObject:self];
        }
    }
}

#pragma mark - 撤销
/** 撤销: 在 _strokeStack里有值就可以撤销 */
- (BOOL)canBackout
{
    if (_strokeStack.length <= 0) {
        /// 没有可撤销的操作
        return NO;
    }
    
    return YES;
}

/** 撤销 */
- (void)backout
{
    if ([self canBackout] == NO) {
        NSLog(@"没有可撤销的操作");
        return ;
    }
    
    /// 将画笔出栈
    TCBrush *brush = [_strokeStack pop];
    if (brush) {
        /// 将画笔的内容从画板上清除
        [brush.layer removeFromSuperlayer];
        /// 恢复撤销栈将此画笔入栈
        [_recoverStack push:brush];
    }
}

#pragma mark - 恢复
/** 恢复: 有撤销就有恢复 */
- (BOOL)canRecover
{
    if (_recoverStack.length <= 0) {
        /// 没有可恢复的操作
        return NO;
    }
    
    return YES;
}

/** 恢复 */
- (void)recover
{
    if ([self canRecover] == NO) {
        NSLog(@"没有可恢复的操作");
        return ;
    }
    
    /// 从恢复撤销栈获取画笔
    TCBrush *brush = [_recoverStack pop];
    if (brush) {
        /// 将画笔中的内容添加到画板上
        [self.layer addSublayer:brush.layer];
        /// 作画栈将此画笔入栈
        [_strokeStack push:brush];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
