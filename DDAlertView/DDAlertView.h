//
//  DDAlertView.h
//  DDAlertView
//
//  Created by 张小冬 on 16/1/23.
//  Copyright © 2016年 dadong. All rights reserved.
//

/*
    1. 创建之后可以用[alertView show]展示，或者直接自己把alertView加到自身的View上。
    2. 模式有警告框可关闭与不可关闭模式两种，如不设置，则默认为能关闭模式。
    3. 当otherButtonTitle有值的时候，则自动变成非强制模式。当只有一个按钮时候，可以自由设置模式
    4. + dismiss方法只是用来备用.可以以类方法形式，移除警告框
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DDAlertViewClosed) {
    DDAlertViewClosedAllowed =  0 , //允许关闭的 模式，(默认值)
    DDAlertViewClosedNoAllowed = 1 //不允许关闭的模式
};

@interface DDAlertView : UIView
/**
 *  当前警告框的关闭模式
 */
@property (nonatomic, assign) DDAlertViewClosed mode ;
/**
 *  创建一个警告框
 *
 *  @param title             标题
 *  @param message           详情文本信息
 *  @param cancelButtonTitle 取消的按钮标题
 *  @param whenClickCancel   当点击取消时候执行的操作
 *  @param otherTitle        其他按钮的标题
 *  @param whenClickOther    当点击其他按钮时候的操作
 *
 *  @return 一个View
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void (^)(void)) whenClickCancel otherButtonTitle:(NSString *)otherTitle otherBlock:(void (^)(void)) whenClickOther ;

- (void) show ;

+ (void)dismiss ;
@end
