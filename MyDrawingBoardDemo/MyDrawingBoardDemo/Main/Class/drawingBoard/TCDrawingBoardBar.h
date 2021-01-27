//
//  TCDrawingBoardBar.h
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 画板工具栏 */
@interface TCDrawingBoardBar : UIView

/** 撤销 */
@property (nonatomic, strong, readonly) UIButton *preBtn;
/** 恢复 */
@property (nonatomic, strong, readonly) UIButton *nextBtn;

@property (nonatomic, copy) void (^itemClick)(int index);

@end

NS_ASSUME_NONNULL_END
