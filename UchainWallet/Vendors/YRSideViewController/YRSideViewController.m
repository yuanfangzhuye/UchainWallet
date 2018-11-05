//
//  YRSideViewController.m
//  YRSnippets
//
//  Created by 王晓宇 on 14-5-10.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRSideViewController.h"

@interface YRSideViewController () <UIGestureRecognizerDelegate>{
    UIView *_baseView;//目前是_baseView
    UIView *_currentView;//其实就是rootViewController.view
    
    UIPanGestureRecognizer *_panGestureRecognizer;
    
    CGPoint _startPanPoint;
    CGPoint _lastPanPoint;
    BOOL _panMovingRightOrLeft;//YES是向右，NO是向左
    
    UIButton *_coverButton;
}
@end

@implementation YRSideViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _leftViewShowWidth = kScreenWidth * 4.0 / 5.0;
        _rightViewShowWidth = 267;
        _animationDuration = 0.35;
        _showBoundsShadow = YES;
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_panGestureRecognizer setDelegate:self];
        
        _panMovingRightOrLeft = NO;
        _lastPanPoint = CGPointZero;
        
        _coverButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [_coverButton addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)init
{
    return [self initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _baseView = self.view;
    [_baseView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.6 blue:0.8 alpha:1]];
    
    self.needSwipeShowMenu = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.rootViewController) {
        NSAssert(NO, @"you must set rootViewController!!");
    }
    if (_currentView!=_rootViewController.view) {
        [_currentView removeFromSuperview];
        _currentView=_rootViewController.view;
        [_baseView addSubview:_currentView];
        _currentView.frame=_baseView.bounds;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRootViewController:(UIViewController *)rootViewController{
    if (_rootViewController!=rootViewController) {
        if (_rootViewController) {
            [_rootViewController removeFromParentViewController];
        }
        _rootViewController=rootViewController;
        if (_rootViewController) {
            [self addChildViewController:_rootViewController];
        }
    }
}

-(void)setLeftViewController:(UIViewController *)leftViewController{
    if (_leftViewController!=leftViewController) {
        if (_leftViewController) {
            [_leftViewController removeFromParentViewController];
        }
        _leftViewController=leftViewController;
        if (_leftViewController) {
            [self addChildViewController:_leftViewController];
        }
    }
}

-(void)setRightViewController:(UIViewController *)rightViewController{
    if (_rightViewController!=rightViewController) {
        if (_rightViewController) {
            [_rightViewController removeFromParentViewController];
        }
        _rightViewController=rightViewController;
        if (_rightViewController) {
            [self addChildViewController:_rightViewController];
        }
    }
}

- (void)changeRootViewController:(UIViewController *)rootViewController{
    if (_rootViewController!=rootViewController) {
        CGRect oldFrame = _rootViewController.view.frame;
        if (_rootViewController) {
            
            [_rootViewController removeFromParentViewController];
            [_rootViewController.view removeFromSuperview];
            
            _rootViewController=rootViewController;
            _rootViewController.view.backgroundColor = [UIColor whiteColor];
            _rootViewController.view.frame = oldFrame;
            _currentView = _rootViewController.view;
            [self addChildViewController:_rootViewController];
            [self.view addSubview:_rootViewController.view];
            [self.view bringSubviewToFront:_rootViewController.view];
        }
    }
    
    [self hideSideViewController:YES];
}


- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu{
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu) {
        [_baseView addGestureRecognizer:_panGestureRecognizer];
    }else{
        [_baseView removeGestureRecognizer:_panGestureRecognizer];
    }
}

- (void)showShadow:(BOOL)show{
    _currentView.layer.shadowOpacity    = show ? 0.8f : 0.0f;
    if (show) {
        _currentView.layer.cornerRadius = 4.0f;
        _currentView.layer.shadowOffset = CGSizeZero;
        _currentView.layer.shadowRadius = 4.0f;
        _currentView.layer.shadowPath   = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
}

#pragma mark  ShowOrHideTheView
- (void)willShowLeftViewController{
    if (!_leftViewController || _leftViewController.view.superview) {
        return;
    }
    _leftViewController.view.frame =_baseView.bounds;
    [_baseView insertSubview:_leftViewController.view belowSubview:_currentView];
    if (_rightViewController && _rightViewController.view.superview) {
        [_rightViewController.view removeFromSuperview];
    }
}

- (void)willShowRightViewController{
    if (!_rightViewController || _rightViewController.view.superview) {
        return;
    }
    _rightViewController.view.frame=_baseView.bounds;
    [_baseView insertSubview:_rightViewController.view belowSubview:_currentView];
    if (_leftViewController && _leftViewController.view.superview) {
        [_leftViewController.view removeFromSuperview];
    }
}

- (void)showLeftViewController:(BOOL)animated{
    if (!_leftViewController) {
        return;
    }
    [self willShowLeftViewController];
    NSTimeInterval animatedTime=0;
    if (animated) {
        animatedTime = ABS(_leftViewShowWidth - _currentView.frame.origin.x) / _leftViewShowWidth * _animationDuration;
    }
    _leftViewController.view.frame = CGRectMake(-kScreenWidth/5, 0, kScreenWidth, kScreenHeight);
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView animateWithDuration:animatedTime animations:^{
        
        [self layoutCurrentViewWithOffset:_leftViewShowWidth];
        [self updateDrawerLeftPercentVisible:1.0f];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
        _leftViewController.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}

- (void)showRightViewController:(BOOL)animated{
    if (!_rightViewController)
    {
        return;
    }
    [self willShowRightViewController];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_rightViewShowWidth + _currentView.frame.origin.x) / _rightViewShowWidth * _animationDuration;
    }
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:-_rightViewShowWidth];
        [_currentView addSubview:_coverButton];
        [self showShadow:_showBoundsShadow];
    }];
}

- (void)hideSideViewController:(BOOL)animated{
    [self showShadow:NO];
    NSTimeInterval animatedTime = 0;
    if (animated) {
        animatedTime = ABS(_currentView.frame.origin.x / (_currentView.frame.origin.x>0?_leftViewShowWidth:_rightViewShowWidth)) * _animationDuration;
    }
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:animatedTime animations:^{
        [self layoutCurrentViewWithOffset:0];
        
        [self updateDrawerLeftPercentVisible:0.0f];
        
    } completion:^(BOOL finished) {
        [_coverButton removeFromSuperview];
        [_leftViewController.view removeFromSuperview];
        [_rightViewController.view removeFromSuperview];
    }];
}
- (void)hideSideViewController{
    [self hideSideViewController:YES];
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Check for horizontal pan gesture
    if (gestureRecognizer == _panGestureRecognizer) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:_baseView];
        
        if ([panGesture velocityInView:_baseView].x < 600 && ABS(translation.x)/ABS(translation.y)>1) {
            if (_currentView.frame.origin.x == 0 && [panGesture velocityInView:_baseView].x < 0.0f ) {
                return NO;
            }
            return YES;
        }
        return NO;
    }
    return YES;
}

- (void)pan:(UIPanGestureRecognizer*)pan
{
    
    if (_panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        _startPanPoint = _currentView.frame.origin;
        if (_currentView.frame.origin.x==0) {
            [self showShadow:_showBoundsShadow];
        }
        CGPoint velocity = [pan velocityInView:_baseView];
        if(velocity.x>0){
            if (_currentView.frame.origin.x>=0 && _leftViewController && !_leftViewController.view.superview) {
                [self willShowLeftViewController];
            }
        }else if (velocity.x<0) {
            if (_currentView.frame.origin.x<=0 && _rightViewController && !_rightViewController.view.superview) {
                [self willShowRightViewController];
            }
        }
        return;
    }
    if (_panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGRect l = self.leftViewController.view.frame;
        CGRect c = _currentView.frame;
        
        
        CGPoint currentPostion = [pan translationInView:_baseView];
        CGFloat xoffset = _startPanPoint.x + currentPostion.x;
        if (xoffset>0) {//向右滑
            if (_leftViewController && _leftViewController.view.superview) {
                xoffset = xoffset>_leftViewShowWidth?_leftViewShowWidth:xoffset;
            }else{
                xoffset = 0;
            }
        }else if(xoffset<0){//向左滑
            if (_rightViewController && _rightViewController.view.superview) {
                xoffset = xoffset<-_rightViewShowWidth?-_rightViewShowWidth:xoffset;
            }else{
                xoffset = 0;
            }
        }
        if (xoffset!=_currentView.frame.origin.x) {
            CGFloat persent = xoffset / _leftViewShowWidth;
            [self updateDrawerLeftPercentVisible:persent];
            [self layoutCurrentViewWithOffset:xoffset];
            l.origin.x = -kScreenWidth/5
            + (xoffset * kScreenWidth/5) / (kScreenWidth/5*4);
            c.origin.x = xoffset;
            
            CGFloat maxDistanceRight = (kScreenWidth *2/ 5.0);
            CGFloat maxDistance = maxDistanceRight;
            CGFloat distance = maxDistance * persent;
            l.origin.x = -(maxDistance-distance);
        }
        
        self.leftViewController.view.frame = l;
    }
    
    if (_panGestureRecognizer.state==UIGestureRecognizerStateEnded) {
        if (_currentView.frame.origin.x!=0 && _currentView.frame.origin.x!=_leftViewShowWidth && _currentView.frame.origin.x!=-_rightViewShowWidth) {
            if (_panMovingRightOrLeft && _currentView.frame.origin.x>20) {
                [self showLeftViewController:YES];
            }else if(!_panMovingRightOrLeft && _currentView.frame.origin.x<-20){
                [self showRightViewController:YES];
            }else{
                [self hideSideViewController];
            }
        }else if (_currentView.frame.origin.x==0) {
            [self showShadow:NO];
        }
        _lastPanPoint = CGPointZero;
    }else{
        CGPoint velocity = [pan velocityInView:_baseView];
        if (velocity.x>0) {
            _panMovingRightOrLeft = YES;
        }else if(velocity.x<0){
            _panMovingRightOrLeft = NO;
        }
        
    }
}


-(void)updateDrawerLeftPercentVisible:(CGFloat)percentVisible{
    
    if (percentVisible > 1.0f) {
        return;
    }
    
    CATransform3D scaleTransform =  CATransform3DMakeScale(1, 1, 1);
    
    CGFloat maxDistanceRight = (kScreenWidth *2/ 5.0);
    //    CGFloat maxDistanceRight = 0;
    
    //CGFloat maxDistance = 50;
    CGFloat maxDistance = maxDistanceRight;
    CGFloat distance = maxDistance * percentVisible;
    CATransform3D translateTransform;
    
    UIViewController * sideDrawerViewController;
    
    sideDrawerViewController = self.leftViewController;
    translateTransform = CATransform3DMakeTranslation(-(maxDistance-distance), 0.0, 0.0);
    //    translateTransform = CATransform3DMakeTranslation((distance), 0.0, 0.0);
    [sideDrawerViewController.view.layer setTransform:CATransform3DConcat(scaleTransform, translateTransform)];
    
    [sideDrawerViewController.view setAlpha:1];
}

//重写此方法可以改变动画效果,PS._currentView就是RootViewController.view
- (void)layoutCurrentViewWithOffset:(CGFloat)xoffset{
    
    if (_showBoundsShadow) {
        _currentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_currentView.bounds].CGPath;
    }
    if (self.rootViewMoveBlock) {//如果有自定义动画，使用自定义的效果
        self.rootViewMoveBlock(_currentView,_baseView.bounds,xoffset);
        return;
    }
    /*平移的动画
     [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y, _baseView.frame.size.width, _baseView.frame.size.height)];
     return;
     //*/
    
    //    /*平移带缩放效果的动画
    static CGFloat h2w = 0;
    if (h2w==0) {
        h2w = _baseView.frame.size.height/_baseView.frame.size.width;
    }
    CGFloat scale = ABS(600 - ABS(xoffset)) / 600;
    scale = MAX(0.8, scale);
    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
    
    CGFloat totalWidth=_baseView.frame.size.width;
    CGFloat totalHeight=_baseView.frame.size.height;
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        totalHeight=_baseView.frame.size.width;
        totalWidth=_baseView.frame.size.height;
    }
    
    if (xoffset>0) {//向右滑的
        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }else{//向左滑的
        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
    }
    //*/
}

@end
