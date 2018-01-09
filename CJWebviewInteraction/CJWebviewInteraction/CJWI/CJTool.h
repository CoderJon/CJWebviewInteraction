//
//  CJTool.h
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJTool : NSObject

/**
 *  设置字号
 *
 *  @param percentFont 百分比字号
 */
+ (void)setCssFont:(NSInteger)percentFont andWebview:(UIWebView *)webview;
/**
 *  设置行距
 *
 *  @param space 行距
 */
+ (void)setCssSpace:(CGFloat)space andWebview:(UIWebView *)webview;

@end
