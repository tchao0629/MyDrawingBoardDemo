//
//  AppDelegate.h
//  MyDrawingBoardDemo
//
//  Created by tangchao on 2021/1/27.
//  Copyright © 2021 tangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

