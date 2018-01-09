//
//  CJBaseFilterView.h
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJBaseFilterView : UIView

@property (nonatomic)UIView *backgroundView;
@property (nonatomic) UIView *menuView;
- (void) toggleMenu;
- (void) showMenu;
- (void) hideMenu;

@end
