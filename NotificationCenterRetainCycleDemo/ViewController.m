//
//  ViewController.m
//  NotificationCenterRetainCycleDemo
//
//  Created by Parsifal on 15/1/12.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"


@interface ViewController ()

@property (strong, nonatomic) MyObject *obj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.obj = [MyObject new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapButton:(UIButton *)sender
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil];
    //释放obj
    if (self.obj)
        self.obj = nil;
}
@end
