//
//  SecondViewController.m
//  Demo-CALayerTest
//
//  Created by Suning on 16/3/30.
//  Copyright © 2016年 jf. All rights reserved.
//


#import "SecondViewController.h"
#import "UIView+Frame.h"

//角度转弧度
#define Angle2Radian(angle) ((angle)/180.0 * M_PI)

@interface SecondViewController (){
    UIImageView *_imgView;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0, 0, 100, 50);
    [nextBtn addTarget:self action:@selector(goingBack) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"back" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [self setUpBackground];
}

-(void)goingBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUpBackground{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
    imgView.frame = CGRectMake(50, 100, 200, 200);
    imgView.centerX = self.view.centerX;
    [self.view addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheImage:)];
    [imgView addGestureRecognizer:tap];
    _imgView = imgView;
    
}

/**
 *  关键帧动画
 *
 */
-(void)clickTheImage:(UIImageView *)imgView{
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anima.values = @[@(Angle2Radian(-5)),@(Angle2Radian(5)),@(Angle2Radian(-5))];
    anima.duration = 0.4;
    anima.repeatCount = MAXFLOAT;
    [_imgView.layer addAnimation:anima forKey:@"shake"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_imgView.layer removeAnimationForKey:@"shake"];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
