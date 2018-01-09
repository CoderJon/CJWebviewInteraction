//
//  ViewController.m
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import "ViewController.h"
#import "CJTool.h"
#import "CJWebComposeView.h"
#import "UIView+DEFrameAdditions.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
@interface ViewController ()<UIWebViewDelegate,CJWebComposeViewDelegate>

@property (nonatomic, strong) UIWebView   *cjWebView;

@property (nonatomic,assign)NSInteger aFont;

@property (nonatomic,assign)CGFloat aSpace;

@property (nonatomic,strong)NSMutableArray *fontArr;

@property (nonatomic,assign)CGFloat preH;

@property (nonatomic,strong)CJWebComposeView *webComposeView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.aSpace = 1.5;
    self.aFont = 100;
    self.cjWebView = [[UIWebView alloc] init];
    self.cjWebView.frame = self.view.bounds;
    self.cjWebView.delegate = self;
    [self.view addSubview:self.cjWebView];
    
    [self downloadData];
    
    self.webComposeView = [[CJWebComposeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.view.deFrameHeight) andDefualtSelect:(NSInteger)(self.aFont - 100)/10];
    self.webComposeView.delegate = self;
    [self.view addSubview:self.webComposeView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 50);
    [btn setTitle:@"点我调整" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)downloadData{
    NSURLSession *session =[NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ynb.114nz.com/Home/Mpublic/mpublic_module_detail"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"Id=%@&module=%@&catId=%@",@"14661",@"news",@"31"] dataUsingEncoding:NSUTF8StringEncoding];
    __weak __typeof(self)weakSelf = self;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        __weak __typeof(self)strongSelf = weakSelf;
        NSString *dataS = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSData *d = [dataS dataUsingEncoding:NSUTF8StringEncoding];
        
        //        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dit = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableLeaves error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.cjWebView loadHTMLString:dit[@"data"][0][@"content"] baseURL:nil];
        });
    }];
    [dataTask resume];
}

- (void)event:(id)sender{
    [self.webComposeView showMenu];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //设置行距
    [CJTool setCssSpace:self.aSpace andWebview:self.cjWebView];
    for (NSInteger i = 0; i < 5; i ++) {
        NSInteger percentFont = 100 + i * 10;
        [CJTool setCssFont:percentFont andWebview:self.cjWebView];
        CGFloat webViewHeight = [[self.cjWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
        NSString * str = [NSString stringWithFormat:@"%f",webViewHeight];
        [self.fontArr addObject:str];

    }
    //字体颜色
    [self.cjWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '333333'"];
    //背景颜色
    //    [self.newsWebview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#21a7f3'"];
    //设置字号
    [CJTool setCssFont:self.aFont andWebview:self.cjWebView];

    CGFloat webViewHeight = 0.0f;
    //document.height
    webViewHeight = [[self.cjWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue] + 10;
    self.preH = webViewHeight;
    self.cjWebView.scrollView.contentSize = CGSizeMake(ScreenWidth, webViewHeight);
}
/**
 *  调整字号
 *
 *  @param idx 字号选项
 */
- (void)returnFontIndex:(NSInteger )idx{
    //字号百分比
    NSInteger percentFont = 100 + idx * 10;
    self.aFont = percentFont;
    [CJTool setCssFont:self.aFont andWebview:self.cjWebView];
    [self changeFrame:self.preH andCurH:[self.fontArr[idx] floatValue]];
    _preH = [self.fontArr[idx] floatValue];
}
/**
 *  改变frame
 *
 *  @param preWebHeight     原frame
 *  @param currentWebHeight 当前frame
 */
- (void)changeFrame:(CGFloat)preWebHeight andCurH:(CGFloat)currentWebHeight{

    self.cjWebView.scrollView.contentSize = CGSizeMake(ScreenWidth, currentWebHeight);
}

- (NSMutableArray *)fontArr{
    if (!_fontArr) {
        _fontArr = [NSMutableArray array];
    }
    return _fontArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
