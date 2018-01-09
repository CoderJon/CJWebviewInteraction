//
//  CJBaseFilterView.m
//  CJWebviewInteraction
//
//  Created by qiaohui on 2018/1/9.
//  Copyright © 2018年 znzx@QH. All rights reserved.
//

#import "CJBaseFilterView.h"

@interface CJBaseFilterView ()
@property (nonatomic) CGRect viewFrame;
@property (nonatomic) CGRect viewHideFrame;
@end

@implementation CJBaseFilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // backgroundView
        self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = .5;
        [self addSubview:self.backgroundView];
        
        _viewFrame = frame;
        _viewHideFrame = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayGestureForTapRecognizer:)];
        //        gesture.delegate = self;
        gesture.cancelsTouchesInView = NO;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:gesture];
        
        self.frame = _viewHideFrame;
        self.alpha = 0;
        self.hidden = YES;
    }
    return self;
}

- (void)toggleMenu {
    if(self.hidden) {
        [self showMenu];
    } else {
        [self hideMenu];
    }
}

- (void)showMenu
{
    self.hidden = NO;
    [UIView animateWithDuration:0.8
                          delay:0.0
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = _viewFrame;
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished){
                     }];
    [UIView commitAnimations];
}

- (void)hideMenu
{
    [UIView animateWithDuration:0.3f
                          delay:0.05f
         usingSpringWithDamping:1.0
          initialSpringVelocity:4.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.frame = _viewHideFrame;
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         self.hidden = YES;
                     }];
    [UIView commitAnimations];
}

- (void)displayGestureForTapRecognizer:(UITapGestureRecognizer *)recognizer {
    CGPoint tapLocation = [recognizer locationInView:self];
    //    NSLog(@"响应2");
    //    [[NSNotificationCenter defaultCenter] postNotificationName:REMOVESELECTCOLOR object:self];
    if (!CGRectContainsPoint(self.menuView.frame, tapLocation) && !self.menuView.hidden) {
        
        [self hideMenu];
    }
}

@end
