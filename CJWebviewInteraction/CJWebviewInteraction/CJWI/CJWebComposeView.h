//
//  CJWebComposeView.h
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import "CJBaseFilterView.h"

@protocol CJWebComposeViewDelegate <NSObject>
@required
- (void)returnFontIndex:(NSInteger )idx;
@optional
- (void)returnSpace:(NSInteger)idx;

@end

@interface CJWebComposeView : CJBaseFilterView

@property (nonatomic,weak)id<CJWebComposeViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame andDefualtSelect:(NSInteger)defualtSelect;

- (void)actualTimeSelectFontIndex:(NSInteger)selectFontIndex;

@end
