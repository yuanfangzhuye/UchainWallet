//
//  UchainProlicyController.m
//  UchainWallet
//
//  Created by 李超 on 2018/11/8.
//  Copyright © 2018 uwallet. All rights reserved.
//

#import "UchainProlicyController.h"
#import <WebKit/WebKit.h>

@interface UchainProlicyController ()

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UILabel *titleL;

@end

@implementation UchainProlicyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self setNav];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController lt_setBackgroundColor:[UIColor whiteColor]];
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:13px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",self.html];
    [self.webView loadHTMLString:htmls baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
}

- (void)setNav
{
    self.navigationItem.titleView = self.titleL;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - getter
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.processPool = [[WKProcessPool alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    }
    return _webView;
}

- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
        _titleL.text = SOLocalizedStringFromTable(@"privatePolicy", nil);
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = [UIColor blackColor];
    }
    return _titleL;
}

@end
