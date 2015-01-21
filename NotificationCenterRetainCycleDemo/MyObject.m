//
//  MyObject.m
//  NotificationCenterRetainCycleDemo
//
//  Created by Parsifal on 15/1/12.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "MyObject.h"

@interface MyObject ()
@property (strong, nonatomic) id localObserver;
@end

@implementation MyObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        /*
         //错误的做法--1、未接收observer，导致无法移除该observer；2、Block内对self有强引用；
         [[NSNotificationCenter defaultCenter] addObserverForName:@"test" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
         NSLog(@"self:%@ note:%@", self, note);
         }];
         */
        
        //正确的做法
        __weak typeof (self) weakSelf = self;
     self.localObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"test" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
         __strong typeof (self) strongSelf = weakSelf;
            NSLog(@"self:%@ note:%@", strongSelf, note);
        }];
    }
    
    return self;
}

- (void)dealloc
{
    //在不需要观察者的时候，移除
    [[NSNotificationCenter defaultCenter] removeObserver:self.localObserver];
    NSLog(@"%s", __FUNCTION__);
}
@end
