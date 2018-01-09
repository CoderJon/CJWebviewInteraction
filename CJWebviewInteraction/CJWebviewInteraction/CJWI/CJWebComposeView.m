//
//  CJWebComposeView.m
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import "CJWebComposeView.h"
#import "CJFilterControl.h"
#import "UIColor+FlatUI.h"
#import "UIView+DEFrameAdditions.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define CJImage(aImage) ([UIImage imageNamed:aImage])
#define SIXGRAY      @"666666"
#define MainColor    @"0881f1"

@interface CJWebComposeView ()

@property (nonatomic) CGRect viewFrame;

@property(nonatomic,strong) CJFilterControl *filter;

@end


@implementation CJWebComposeView

- (id)initWithFrame:(CGRect)frame andDefualtSelect:(NSInteger)defualtSelect{
    self = [super initWithFrame:frame];
    if (self) {
        _viewFrame = frame;
        //        _preProvince = @"全部";
        self.menuView =[[UIView alloc] initWithFrame:CGRectMake(0, (ScreenHeight - 64)/2.0, ScreenWidth, 80)];
        self.menuView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.menuView];
        
        
        UILabel *fontLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 50, 30)];
        fontLabel.backgroundColor = [UIColor clearColor];
        fontLabel.text = @"字号";
        fontLabel.textColor = [UIColor colorFromHexCode:SIXGRAY];
        [self.menuView addSubview:fontLabel];
        
        UIImage *minImg = CJImage(@"t_small");
        UIImage *maxImg = CJImage(@"t_lager");
        UIImageView *minImageV = [[UIImageView alloc] initWithFrame:CGRectMake(fontLabel.deFrameRight, fontLabel.deFrameTop, minImg.size.width, minImg.size.height)];
        minImageV.center = CGPointMake(fontLabel.center.x + fontLabel.deFrameWidth/2.0 + 5, fontLabel.center.y);
        minImageV.image = minImg;
        [self.menuView addSubview:minImageV];
        
        _filter = [[CJFilterControl alloc]initWithFrame:CGRectMake(minImageV.deFrameRight, 5, ScreenWidth - 80 - minImg.size.width - maxImg.size.width, 10) Titles:[NSArray arrayWithObjects:@"特小", @"小", @"中", @"大",@"特大",nil]];
        _filter.backgroundColor = [UIColor clearColor];
        [_filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
        [_filter setTopTitlesColor:[UIColor colorFromHexCode:MainColor]];//设置滑块上方字体颜色
        [_filter setSelectedIndex:defualtSelect];//设置当前选中
        [self.menuView addSubview:_filter];
        
        
        UIImageView *maxImageV = [[UIImageView alloc] initWithFrame:CGRectMake(_filter.deFrameRight + 5, fontLabel.deFrameTop, maxImg.size.width, maxImg.size.height)];
        maxImageV.center = CGPointMake(_filter.deFrameRight + 5 + maxImg.size.width/2.0, minImageV.center.y);
        maxImageV.image = maxImg;
        [self.menuView addSubview:maxImageV];
        
        /*行间距
         UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.menuView.deFrameHeight / 2.0, self.menuView.deFrameWidth, 1.0)];
         lineView.backgroundColor = [UIColor colorFromHexCode:@"e5e5e5"];
         [self.menuView addSubview:lineView];
         
         
         QHArticleSpaceView *spaceView = [[QHArticleSpaceView alloc] initWithFrame:CGRectMake(70, lineView.deFrameBottom + 5, self.menuView.deFrameWidth - 100, 70) normalImage:@[@"small",@"middle",@"lager"] selectImage:@[@"small_",@"middle_",@"lager_"] andDefault:1];
         @weakify(self)
         spaceView.SpaceSelectIndexBlcok = ^(NSInteger idx){
         @strongify(self);
         if ([self.delegate respondsToSelector:@selector(returnSpace:)]) {
         [self.delegate returnSpace:idx];
         }
         };
         spaceView.backgroundColor = [UIColor clearColor];
         [self.menuView addSubview:spaceView];
         
         UILabel *spaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(fontLabel.deFrameLeft, lineView.deFrameBottom + 25, fontLabel.deFrameWidth, fontLabel.deFrameHeight)];
         spaceLabel.backgroundColor = [UIColor clearColor];
         spaceLabel.text = @"间距";
         spaceLabel.textColor = [UIColor colorFromHexCode:SIXGRAY];
         [self.menuView addSubview:spaceLabel];
         
         */
    }
    return self;
}

- (void)actualTimeSelectFontIndex:(NSInteger)selectFontIndex{
    [_filter setSelectedIndex:selectFontIndex];
}

#pragma mark -- 点击底部按钮响应事件
-(void)filterValueChanged:(CJFilterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    if ([self.delegate respondsToSelector:@selector(returnFontIndex:)]) {
        [self.delegate returnFontIndex:sender.SelectedIndex];
    }
    
}

@end
