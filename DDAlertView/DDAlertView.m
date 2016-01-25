//
//  DDAlertView.m
//  DDAlertView
//
//  Created by 张小冬 on 16/1/23.
//  Copyright © 2016年 dadong. All rights reserved.
//

#import "DDAlertView.h"
#import "NSString+DD.h"
#undef DD_SCREEN_WIDTH
#define DD_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width) //宽

#undef DD_SCREEN_HEIGHT
#define DD_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height) //高

#define DDAlertView_Width (DD_SCREEN_WIDTH/2) //定义警告框的宽
#define DDAlertView_Font ([UIFont systemFontOfSize:13]) ; //默认字体
@interface DDAlertView(){
    NSString *_title ;
    NSString *_message ;
    NSString *_cancelTitle ;
    NSString *_otherTitle ;
}
@property (nonatomic, weak)UILabel *titleLabel ;
@property (nonatomic, weak)UILabel *messageLable ;
@property (nonatomic, weak)UIButton *cancelBtn ;
@property (nonatomic, weak)UIButton *otherBtn ;
@property (nonatomic, copy)void (^whenClickCancel)(void);
@property (nonatomic, copy)void (^whenClickOther)(void);

@end
@implementation DDAlertView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(void (^)(void)) whenClickCancel otherButtonTitle:(NSString *)otherTitle otherBlock:(void (^)(void)) whenClickOther
{
    if (self = [super init]) {
        _title = title ;
        _message = message ;
        _cancelTitle = cancelButtonTitle ;
        _otherTitle = otherTitle ;
        _whenClickCancel = whenClickCancel ;
        _whenClickOther = whenClickOther ;
        [self initView];
    }
    return self ;
}
- (void)initView
{
    //自身做遮罩层
    self.frame = CGRectMake(0, 0, DD_SCREEN_WIDTH, DD_SCREEN_HEIGHT) ;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    self.alpha = 0.2 ;
    
    //增加一个白底
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5 ;//设置弧边
    whiteView.layer.masksToBounds = YES ;
    CGFloat x = (DD_SCREEN_WIDTH - DDAlertView_Width)/2 ;
    CGFloat h = self.bounds.size.height ;
    whiteView.frame = CGRectMake(x, 64, DDAlertView_Width, h - 64 - 49);
    [self addSubview:whiteView];
    
    //标题
    CGFloat titleH = 25 ;
    UILabel *titleLabel = [[UILabel alloc]init];
    _titleLabel = titleLabel ;
    titleLabel.text = _title ;
    [whiteView addSubview:titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.frame = CGRectMake(0, 0, DDAlertView_Width, titleH);
    titleLabel.textAlignment = NSTextAlignmentCenter ;
    titleLabel.textColor = [UIColor redColor];
//    titleLabel.font = ;
    
    //文本
    CGFloat msgW = DDAlertView_Width - 50 ;
    CGFloat msgX = (DDAlertView_Width - msgW )/2 ;
    UILabel *messageLabel = [[UILabel alloc]init];
    _messageLable = messageLabel ;
    messageLabel.numberOfLines = 0 ;
    messageLabel.textAlignment = NSTextAlignmentCenter ;
    _messageLable.font = [UIFont systemFontOfSize:12] ;
    [whiteView addSubview:messageLabel];
    messageLabel.text = _message ;
    CGSize msgSize = [_message sizeOfFont:_messageLable.font  maxWidth:msgW maxHeight:(DD_SCREEN_HEIGHT - 84 - 49 - 30*2)];
    CGFloat msgY = CGRectGetMaxY(titleLabel.frame)+ 8;
    CGFloat msgH = msgSize.height ;
    messageLabel.frame = CGRectMake(msgX,msgY, msgW,msgH);
    
    //一个分割线
    CGFloat lineY =  CGRectGetMaxY(messageLabel.frame) + 8 ;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, lineY, DDAlertView_Width, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.5 ;
    [whiteView addSubview:line];
    
    
    //取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
     [cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    cancelBtn.titleLabel.font = DDAlertView_Font ;
    [cancelBtn setTitle:_cancelTitle forState:UIControlStateNormal];
    [cancelBtn setTitle:_cancelTitle forState:UIControlStateHighlighted];
    [whiteView addSubview:cancelBtn];
    _cancelBtn = cancelBtn ;
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat cancelY = lineY + 1 ;
    CGFloat cancelH = 30 ;
    if (!_otherTitle) {
        //只有一个按钮
        cancelBtn.frame = CGRectMake(0, cancelY, DDAlertView_Width, cancelH );
    }else{
        //两个按钮
        CGFloat cancelW = DDAlertView_Width /2 ;
        cancelBtn.frame = CGRectMake(0, cancelY, cancelW, cancelH);
        
        //其他按钮
        UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [otherBtn setTitle:_otherTitle forState:UIControlStateNormal];
        [otherBtn setTitle:_otherTitle forState:UIControlStateHighlighted];
        otherBtn.titleLabel.font = DDAlertView_Font ;
        [whiteView addSubview:otherBtn];
        _otherBtn = otherBtn ;
        otherBtn.backgroundColor = [UIColor whiteColor];
        [otherBtn addTarget:self action:@selector(other:) forControlEvents:UIControlEventTouchUpInside];
        otherBtn.frame = CGRectMake(cancelW + 1, cancelY, cancelW, cancelH);
        
        //树型分割线
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(cancelW, cancelY, 0.5, cancelH)];
        line2.backgroundColor = [UIColor grayColor];
        line2.alpha = 0.5 ;
        [whiteView addSubview:line2];
    }
    
    CGFloat whiteX = x ;
    CGFloat whiteH = CGRectGetMaxY(cancelBtn.frame);
    CGFloat whiteY = (h - whiteH)/2 ;
    CGFloat whiteW = DDAlertView_Width ;
    whiteView.frame = CGRectMake(whiteX, whiteY, whiteW, whiteH);
}


- (void)cancel:(UIButton *)button
{
    if (self.whenClickCancel) {
        self.whenClickCancel();
    }
    if (_otherTitle || _mode == DDAlertViewClosedAllowed) {
        [self removeFromSuperview];
    }
}

- (void)other:(UIButton *)button
{
    if (self.whenClickOther) {
        self.whenClickOther();
    }
    [self removeFromSuperview];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

+ (void)dismiss
{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
            return ;
        }
    }
}
@end
