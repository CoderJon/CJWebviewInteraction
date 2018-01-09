//
//  CJFilterControl.h
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJFilterControl : UIControl

-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
-(void) setSelectedIndex:(NSInteger)index;
-(void) setTitlesFont:(UIFont *)font;

@property(nonatomic, strong) UIButton *handler;
@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic, strong) UIColor *TopTitlesColor;
@property(nonatomic, readonly) NSInteger SelectedIndex;

@end
