//
//  JLInputView.m
//  JLInputView
//
//  Created by 张天龙 on 17/3/27.
//  Copyright © 2017年 张天龙. All rights reserved.
//

#import "JLInputView.h"

@interface JLInputView ()
/**
 *  占位文字View: 为什么使用UITextView，这样直接让占位文字View = 当前textView,文字就会重叠显示
 */
@property (nonatomic, weak) UITextView *placeholderView;
/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;

@end

@implementation JLInputView

- (UITextView *)placeholderView
{
    if (_placeholderView == nil) {
        UITextView *placeholderView = [[UITextView alloc] init];
        _placeholderView = placeholderView;
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setup];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    
    // 计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setTextHeightChangeBlock:(void (^)(NSString *, CGFloat))textChangeBlock
{
    _textHeightChangeBlock = textChangeBlock;
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
}

- (void)setPlaceholderHidden:(BOOL)placeholderHidden{
    
    _placeholderHidden = placeholderHidden;
    
    _placeholderView.hidden = YES;
    
}

- (void)setFont:(UIFont *)font{
    
    _placeholderView.font = font;
    
    [super setFont:font];
    
}


- (void)textDidChange
{
    if (!_placeholderHidden) {
        // 占位文字是否显示
        self.placeholderView.hidden = self.text.length>0;
    }
    
    //ceilf(n):去大于或者等于数值n的整数
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (height >= _maxTextH)
    {
        height = _maxTextH;
        self.scrollEnabled = YES;   // 允许滚动
    }
    else
    {
        self.scrollEnabled = NO;    // 不允许滚动
        
    }
    
    //修改父控件的高度，输入框跟着改变
    _textHeightChangeBlock(self.text,height);

    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _placeholderView.frame = self.bounds;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
