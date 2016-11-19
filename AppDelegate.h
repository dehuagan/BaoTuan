//
//  AppDelegate.h
//  BaoTuan
//
//  Created by 甘徳华 on 2016/10/25.
//  Copyright © 2016年 GDH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

