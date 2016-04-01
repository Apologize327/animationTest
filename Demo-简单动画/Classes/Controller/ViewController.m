//
//  ViewController.m
//  Demo-CALayerTest
//
//  Created by Suning on 16/3/29.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "SecondViewController.h"
#import "TransitionViewController.h"
#import "ThirdViewController.h"

#define mScreenWidth    [UIScreen mainScreen].bounds.size.width
#define mScreenHeight    [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property(nonatomic,strong) UIView *animaView;
@property(nonatomic,strong) NSArray *nameArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(10, 0, 100, 50);
    [nextBtn setTitle:@"图标抖动页" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(clickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn2.frame = CGRectMake(nextBtn.right+20 , 0, 100, 50);
    [nextBtn2 setTitle:@"转场动画页" forState:UIControlStateNormal];
    [nextBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn2];
    [nextBtn2 addTarget:self action:@selector(clickTheThirdBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn3.frame = CGRectMake(nextBtn2.right+20 , 0, 100, 50);
    [nextBtn3 setTitle:@"综合案例" forState:UIControlStateNormal];
    [nextBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn3];
    [nextBtn3 addTarget:self action:@selector(clickTheFouthBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor brownColor];
    [self.view addSubview:view];
    self.animaView = view;
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 10, 10)];
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    
    
    self.nameArr = [NSArray arrayWithObjects:@"平移",@"缩放",@"旋转",@"变色", nil];
    
    [self setUpMoveBtns];
}

-(void)setUpMoveBtns{
    NSInteger indexNum = 3; //每行按钮数
    NSInteger btnCount = self.nameArr.count; //按钮总数
    CGFloat btnW = 50;
    CGFloat space = (mScreenWidth - indexNum*btnW)/(indexNum+1);
    
    for (NSInteger i=0; i<btnCount; i++) {
        NSInteger rowNum = i/indexNum; //行号
        NSInteger columnNum = i%indexNum; //列号
        CGFloat btnX = space + (btnW + space)*columnNum;
        CGFloat btnY = mScreenHeight -250 + 30 + (30 + btnW)*rowNum;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnW);
        [btn setTitle:[self.nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.tag = i;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(clickTheBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)clickTheBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 0:
            [self testTranslate];
            break;
        case 1:
            [self testScale];
            break;
        case 2:
            [self testRotate];
            break;
        case 3:
            [self testColorChange];
            break;
            
        default:
            break;
    }
}

/**
 *  平移动画
 */
-(void)testTranslate{
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform.translation";
    //位移是view.layer的position值从一个转为另一个，并且toValue是移动距离，而不是position到达那个点
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    anima.duration = 1.0f;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    [self.animaView.layer addAnimation:anima forKey:nil];
}

/**
 *  缩放
 */
-(void)testScale{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    anima.toValue = @(1.5);
    anima.duration = 1.0f;
    [self.animaView.layer addAnimation:anima forKey:nil];
    
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anima2.toValue = @(0.5);
    anima2.duration = 1.0f;
    [self.animaView.layer addAnimation:anima2 forKey:nil];
}

/**
 *  旋转
 */
-(void)testRotate{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI_4);
    anima.duration = 1.0f;
    [self.animaView.layer addAnimation:anima forKey:nil];
}

/**
 *  背景色渐变
 */
-(void)testColorChange{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anima.toValue = (id)[UIColor greenColor].CGColor;
    anima.duration = 1.0f;
    [self.animaView.layer addAnimation:anima forKey:nil];
}

-(void)clickNextBtn{
    SecondViewController *sec = [[SecondViewController alloc]init];
    [self presentViewController:sec animated:YES completion:nil];
}

-(void)clickTheThirdBtn{
    TransitionViewController *third = [[TransitionViewController alloc]init];
    [self presentViewController:third animated:YES completion:nil];
}

-(void)clickTheFouthBtn{
    ThirdViewController *third = [[ThirdViewController alloc]init];
    [self presentViewController:third animated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
