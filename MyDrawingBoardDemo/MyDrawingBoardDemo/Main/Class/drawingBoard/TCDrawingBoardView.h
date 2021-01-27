//
//  TCDrawingBoardView.h
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 画板协议 */
@class TCDrawingBoardView;
@protocol TCDrawingBoardViewDelegate <NSObject>

/** 作画结束 */
- (void)brushFinish:(TCDrawingBoardView *)drawingBoardView;

@end

/** 画板 */
@interface TCDrawingBoardView : UIView

@property (nonatomic, weak) id<TCDrawingBoardViewDelegate> delegate;

/** 是否可以撤销 */
- (BOOL)canBackout;
/** 撤销 */
- (void)backout;

/** 是否可以恢复 */
- (BOOL)canRecover;
/** 恢复 */
- (void)recover;

@end

NS_ASSUME_NONNULL_END
