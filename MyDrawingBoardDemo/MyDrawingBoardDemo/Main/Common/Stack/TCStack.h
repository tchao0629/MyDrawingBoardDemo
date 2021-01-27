//
//  TCBrushStack.h
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 栈 */
@interface TCStack<TCObjectType> : NSObject

/** 栈的大小 */
- (int)length;

/** 入栈
 */
- (void)push:(TCObjectType)object;
/** 出栈 */
- (TCObjectType)pop;

/** 获取栈顶元素 */
- (TCObjectType)peek;

/** 将栈清空 */
- (void)clear;


@end

NS_ASSUME_NONNULL_END
