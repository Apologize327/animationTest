//
//  FouthViewController.m
//  Demo-简单动画
//
//  Created by Suning on 16/4/1.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "ThirdViewController.h"
#import "UIView+Frame.h"

#define mScreenWidth    [UIScreen mainScreen].bounds.size.width
#define mScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ThirdViewController (){
    UIImageView *_bottomView; //最底部的加号
    BOOL isTransformed; //标记加号按钮是否已移动
    NSMutableArray *_itemArr; //item集合
}

@property(nonatomic,strong) NSMutableArray *itemDesArr;//item展开后的中心点集合

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0.9;
    _itemArr = [NSMutableArray array];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0, 0, 100, 50);
    [nextBtn addTarget:self action:@selector(goingBack) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"back" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    [self setUpBackground];
}

-(void)setUpBackground{
    UIImageView *bottomView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 350, 50, 50)];
    bottomView.image = [UIImage imageNamed:@"chooser-button-input"];
    bottomView.centerX = self.view.centerX;
    [self.view addSubview:bottomView];
    bottomView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTheBottomView)];
    [bottomView addGestureRecognizer:tap];
    _bottomView = bottomView;
    
    //弹出的子项数目
    NSInteger itemCount = 5;
    for (NSInteger i=0; i<itemCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bottomView.frame;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"item%ld",i+1]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"chooser-moment-button"] forState:UIControlStateNormal];
        btn.tag = i;
        btn.hidden = YES;
        btn.layer.cornerRadius = btn.width/2;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(clickItemBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [_itemArr addObject:btn];
    }
}

-(void)clickTheBottomView{
    /**
     * 用basicAnimation时回到初始位置会丢失动画效果
     *
     */
//    CABasicAnimation *anima = [CABasicAnimation animation];
//    anima.keyPath = @"transform.rotation";
//    anima.duration = 0.25;
//    anima.fillMode = kCAFillModeForwards;
//    anima.removedOnCompletion = NO;
//    if (!isTransformed) {
//        anima.toValue = @(-M_PI_4);
//        isTransformed = YES;
//    } else {
//        anima.toValue = @(0);
//        isTransformed = NO;
//    }
//    
//    [_bottomView.layer addAnimation:anima forKey:@"bottomView"];
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animation];
    anima.keyPath = @"transform.rotation";
    anima.duration = 0.15;
    anima.fillMode = kCAFillModeForwards;
    anima.removedOnCompletion = NO;
    if (!isTransformed) {
        anima.values = @[@(0),@(-M_PI_4)];
        isTransformed = YES;
        [self showItemAnimation];
    } else {
        anima.values = @[@(-M_PI_4),@(0)];
        isTransformed = NO;
        [self hideItemAnimation];
    }
    [_bottomView.layer addAnimation:anima forKey:@"bottomView"];
    
    
}

/** 展示子选项 */
-(void)showItemAnimation{
    
    for (NSInteger i=0; i<self.itemDesArr.count; i++) {
        /** 
         * 该种位移方式不能正确显示到位置上
         *
         */
//        CABasicAnimation *anima1 = [CABasicAnimation animation];
//        anima1.keyPath = @"transform.translation";
//        anima1.toValue = [_itemDesArr objectAtIndex:i];
        
        //旋转
        CAKeyframeAnimation *anima2 = [CAKeyframeAnimation animation];
        anima2.keyPath = @"transform.rotation";
        anima2.values = @[@(0),@(M_PI*2)];
        
        UIButton *btn = [_itemArr objectAtIndex:i];
        btn.hidden = NO;
        
        [UIView animateWithDuration:0.25 animations:^{
            //位移
            CGRect rect;
            CGPoint a = [[self.itemDesArr objectAtIndex:i] CGPointValue];
            rect.size = _bottomView.frame.size;
            btn.frame = rect;
            btn.centerX = a.x;
            btn.centerY = a.y;
            
            //旋转
            [btn.layer addAnimation:anima2 forKey:nil];
        }];
    }
}

/** 隐藏item */
-(void)hideItemAnimation{
    for (NSInteger i=0; i<_itemArr.count; i++) {
        
        CAKeyframeAnimation *anima2 = [CAKeyframeAnimation animation];
        anima2.keyPath = @"transform.rotation";
        anima2.values = @[@(0),@(M_PI*2)];

        UIButton *btn = [_itemArr objectAtIndex:i];
        
        [UIView animateWithDuration:0.25 animations:^{
            btn.frame = _bottomView.frame;
            [btn.layer addAnimation:anima2 forKey:nil];
        } completion:^(BOOL finished) {
            btn.hidden = YES;
        }];
        
    }
}

-(void)clickItemBtn:(UIButton *)btn{
    
}

-(NSMutableArray *)itemDesArr{
    if (!_itemDesArr) {
        _itemDesArr = [NSMutableArray array];
        //item展开显示的是圆形的几个点，可以看做是7个点平分半个圆，算出中心点
        CGFloat radius = 150;
        CGFloat bottomCenterX = _bottomView.centerX;
        CGFloat bottomCenterY = _bottomView.centerY;
        //每个item之间夹角
        CGFloat angle = M_PI/6;
        for (NSInteger i=0; i<7; i++) {
            CGFloat centerX = bottomCenterX - radius*cos(i*angle);
            CGFloat centerY = bottomCenterY - radius*sin(i*angle);
            CGPoint point = CGPointMake(centerX, centerY);
            [_itemDesArr addObject:[NSValue valueWithCGPoint:point]];
        }
        //删除第一个和最后一个点
        [_itemDesArr removeObjectAtIndex:0];
        [_itemDesArr removeLastObject];
    }
    return _itemDesArr;
}

-(void)goingBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
