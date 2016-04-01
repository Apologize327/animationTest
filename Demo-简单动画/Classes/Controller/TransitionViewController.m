//
//  TransitionViewController.m
//  Demo-简单动画
//
//  Created by Suning on 16/3/31.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "TransitionViewController.h"
#import "UIView+Frame.h"
#import "ViewController.h"

@interface TransitionViewController ()

@property(nonatomic,strong) UIImageView *imgView;

/** 图片索引 */
@property(nonatomic,assign) NSInteger indexNum;

@end

@implementation TransitionViewController

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

-(void)setUpBackground{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    imgView.frame = CGRectMake(50, 100, 150, 200);
    imgView.centerX = self.view.centerX;
    [self.view addSubview:imgView];
    self.imgView = imgView;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(50, imgView.bottom+30, 100, 50);
    [nextBtn addTarget:self action:@selector(clickTheNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"下一张" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    UIButton *previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    previousBtn.frame = CGRectMake(nextBtn.right+100, imgView.bottom+30, 100, 50);
    [previousBtn addTarget:self action:@selector(clickThePreviousBtn) forControlEvents:UIControlEventTouchUpInside];
    [previousBtn setTitle:@"上一张" forState:UIControlStateNormal];
    [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:previousBtn];
    
}

-(void)clickTheNextBtn{
    self.indexNum++;
    if (self.indexNum == 10) {
        self.indexNum = 0;
    }
    NSString *imgName = [NSString stringWithFormat:@"%ld",(self.indexNum+1)];
    self.imgView.image = [UIImage imageNamed:imgName];
    
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";
    anima.subtype = kCATransitionFromLeft;
    anima.duration = 1.0f;
    [self.imgView.layer addAnimation:anima forKey:nil];
}

-(void)clickThePreviousBtn{
    self.indexNum--;
    if (self.indexNum == -1) {
        self.indexNum = 9;
    }
    NSString *imgName = [NSString stringWithFormat:@"%ld",(self.indexNum+1)];
    self.imgView.image = [UIImage imageNamed:imgName];
    
    CATransition *anima = [CATransition animation];
    anima.type = @"cube";
    anima.duration = 1.0f;
    anima.subtype = kCATransitionFromRight;
    [self.imgView.layer addAnimation:anima forKey:nil];
}

-(void)goingBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
