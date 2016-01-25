//
//  NSString+DD.h
//  DDAlertView
//
//  Created by 张小冬 on 16/1/23.
//  Copyright © 2016年 dadong. All rights reserved.
//


#import <UIKit/UIKit.h>
//定义系统版本
#undef IOS_7_OR_LATER
#define IOS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#undef IOS_9_OR_LATER
#define IOS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0 ? YES : NO)
@interface NSString (DD)
/**
 *  计算一个自定义字符串的大小
 *
 *  @param font       字体
 *  @param max_width  最大宽度
 *  @param max_height 最大高度
 *
 *  @return 计算出的大小
 */
- (CGSize)sizeOfFont:(UIFont *)font maxWidth:(CGFloat)max_width maxHeight:(CGFloat)max_height;
@end
