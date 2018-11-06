//
//  UchainWelcomePageViewController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/6.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainWelcomePageViewController.h"

@interface UchainWelcomePageViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation UchainWelcomePageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self loadIntroduceWelcomePage];
    [self.view addSubview:_scrollView];
}

- (instancetype)initWithWelcomeController
{
    self = [super init];
    if (self) {
//        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.pagingEnabled = YES;
//        _scrollView.bounces = NO;
//        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//        _scrollView.backgroundColor = [UIColor whiteColor];
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//
//        [self loadIntroduceWelcomePage];
//        [self.view addSubview:_scrollView];
    }
    
    return self;
}

- (void)loadIntroduceWelcomePage
{
    NSArray *imageArray;
    
    NSMutableArray *liteImageNameArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= kWelcomePageNumber; i++) {
//        NSString *imageNameStr = [NSString stringWithFormat:@"icon_start%ld_small", (long)i];
        [liteImageNameArray addObject:@"walletBackgroundImage"];
    }
    
    NSMutableArray *largeImageNameArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= kWelcomePageNumber; i++) {
//        NSString *imageNameStr = [NSString stringWithFormat:@"icon_start%ld_large", (long)i];
        [largeImageNameArray addObject:@"walletBackgroundImage"];
    }
    
    NSMutableArray *iphohexImageNameArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= kWelcomePageNumber; i++) {
//        NSString *imageNameStr = [NSString stringWithFormat:@"icon_start%ld_iphonex", (long)i];
        [iphohexImageNameArray addObject:@"walletBackgroundImage"];
    }
    
    if (iPhoneX) {
        imageArray = iphohexImageNameArray;
    }
    else {
        if (kScreenWidth == 480) {
            imageArray = liteImageNameArray;
        }
        else {
            imageArray = largeImageNameArray;
        }
    }
    
    [self loadImageForScrollView:imageArray];
}

- (void)loadImageForScrollView:(NSArray *)imageArray
{
    _scrollView.contentSize = CGSizeMake(imageArray.count * kScreenWidth, kScreenHeight);
    
    for (NSInteger i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArray objectAtIndex:i]]];
        [_scrollView addSubview:imageView];
        
        if (i == imageArray.count - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            [button addTarget:self action:@selector(quitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
        }
    }
}

- (void)quitButtonClick:(id)sender
{
    if (self.didFinishScrollerWelcomeSub) {
        [self.didFinishScrollerWelcomeSub sendNext:@""];
    }
    
//    if (_returnWelcomePageBlock != nil) {
//        _returnWelcomePageBlock();
//    }
}

- (void)returnWelcomePageBlock:(ReturnWelcomePageBlock)block
{
    _returnWelcomePageBlock = block;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
