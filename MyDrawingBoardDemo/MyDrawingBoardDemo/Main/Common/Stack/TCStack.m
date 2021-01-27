//
//  TCBrushStack.m
//  Test
//
//  Created by tangchao on 2021/1/26.
//  Copyright © 2021 Midas. All rights reserved.
//

#import "TCStack.h"

@interface TCStack<TCObjectType> ()
{
    @private
    int _size;
    NSMutableArray<TCObjectType> *_array;
}

@end

@implementation TCStack

- (int)length
{
    return _size;
}

- (void)push:(id)object
{
    if (!object) {
        NSLog(@"param not is nil.");
        return ;
    }
    
    if (!_array) {
        _array = [NSMutableArray array];
        _size = 0;
    }
    
    [_array addObject:object];
    _size++;
}

- (id)pop
{
    if (_array.count == 0) {
        NSLog(@"this is a empty stack.");
        return nil;
    }
    
    id object = [_array lastObject];
    
    [_array removeLastObject];
    _size--;
    return object;
}

- (id)peek
{
    if (_array.count == 0) {
        NSLog(@"this is a empty stack.");
        return nil;
    }
    
    id object = [_array lastObject];
    
    return object;
}

- (void)clear
{
    [_array removeAllObjects];
    _size = 0;
}



@end
