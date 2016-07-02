//
//  ViewController.m
//  Day02_Practice
//
//  Created by yingxin on 16/7/1.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "ViewController.h"

#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, readonly) UIColor *randomColor;
@end

@implementation ViewController

- (UIColor *)randomColor{
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *lastView = nil;
    for (int i = 0; i < 9; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:btn];
        btn.backgroundColor = self.randomColor;
        btn.layer.cornerRadius = 4; //圆角
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(20);
            make.height.equalTo(50);
            
            //调整不同位置的item的宽度
            if (i == 0) {
                make.width.equalTo(self.view).dividedBy(3);
            }else if(i < 5){
                make.width.equalTo(lastView).equalTo(40);
            }else{
                make.width.equalTo(lastView).equalTo(-40);
            }
            //第一个视图时, lastView == nil, 距离上边缘20像素
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).equalTo(20);
            }else{
                make.top.equalTo(20);
            }
        }];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        lastView = btn;
    }
}

- (void)btnClicked:(UIButton *)sender{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"i %d", i);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            sender.backgroundColor = self.randomColor;
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end











