//
//  NSString+DD.m
//  DDAlertView
//
//  Created by 张小冬 on 16/1/23.
//  Copyright © 2016年 dadong. All rights reserved.
//

#import "NSString+DD.h"

@implementation NSString (DD)
- (CGSize)sizeOfFont:(UIFont *)font maxWidth:(CGFloat)max_width maxHeight:(CGFloat)max_height
{
    if (IOS_7_OR_LATER) {
        //ios_7之后的
        NSDictionary *dic = @{
                              NSFontAttributeName:font,
                              NSForegroundColorAttributeName:[UIColor blackColor]
                              };
        return [self boundingRectWithSize:CGSizeMake(max_width, max_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }else{
        //ios_7之前的
        return [self sizeWithFont:font constrainedToSize:CGSizeMake(max_width, max_height) lineBreakMode:NSLineBreakByTruncatingTail];
    }
}
@end
