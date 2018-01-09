//
//  CJTool.m
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import "CJTool.h"

@implementation CJTool

/**
 *  设置字号
 *
 *  @param percentFont 百分比字号
 */
+ (void)setCssFont:(NSInteger)percentFont andWebview:(UIWebView *)webview{
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%ld%%'",(long)percentFont];
    //设置css
    [webview stringByEvaluatingJavaScriptFromString:str];
}
/**
 *  设置行距
 *
 *  @param space 行距
 */
+ (void)setCssSpace:(CGFloat)space andWebview:(UIWebView *)webview{
    [webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.lineHeight='%f'",space]];
}

@end
