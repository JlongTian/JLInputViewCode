//
//  JLToobar.m
//  JLInputView
//
//  Created by 张天龙 on 17/3/27.
//  Copyright © 2017年 张天龙. All rights reserved.
//

#import "JLToobar.h"
#import "JLInputView.h"

#define kBtnHW 30
#define kBtnMargin 5

@interface JLToobar ()

/**
 语音按钮
 */
@property (nonatomic,weak) UIButton *voiceBtn;

/**
 输入框
 */
@property (nonatomic,weak) JLInputView *inputView;

/**
 表情按钮
 */
@property (nonatomic,weak) UIButton *emojiBtn;

/**
 添加按钮
 */
@property (nonatomic,weak) UIButton *addBtn;


@end

@implementation JLToobar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.语音按钮
        UIButton *voiceBtn = [[UIButton alloc] init];
        voiceBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [voiceBtn setBackgroundImage:[UIImage imageNamed:@"sound"] forState:UIControlStateNormal];
        [self addSubview:voiceBtn];
        _voiceBtn = voiceBtn;
        
        //2.输入框
        JLInputView *inputView = [[JLInputView alloc] init];
        // 设置文本框占位文字
        inputView.placeholder = @"请输入内容";
        inputView.placeholderColor = [UIColor lightGrayColor];
        inputView.font = [UIFont systemFontOfSize:16.0];
        //如果不需要占位文字就将placeholderHidden设置为YES
        //_inputView.placeholderHidden = YES;
        // 监听文本框文字高度改变
        __weak JLToobar *weakSelf = self;
        inputView.textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
            
            CGRect frame = weakSelf.frame;
            CGFloat originalH = frame.size.height;
            frame.size.height = textHeight + 10;
            //其实整数或者负数都是这样子减
            CGFloat difference = frame.size.height-originalH;
            frame.origin.y = frame.origin.y - difference;
            weakSelf.frame = frame;
            
        };
        
        // 设置文本框最大行数
        inputView.maxNumberOfLines = 4;
        [self addSubview:inputView];
        _inputView = inputView;
        
        //3.表情按钮
        UIButton *emojiBtn = [[UIButton alloc] init];
        [emojiBtn setBackgroundImage:[UIImage imageNamed:@"smail"] forState:UIControlStateNormal];
        [self addSubview:emojiBtn];
        _emojiBtn = emojiBtn;
        
        //4.添加按钮
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [self addSubview:addBtn];
        _addBtn = addBtn;
        
        // 5.监听键盘弹出
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

        
    }
    return self;
}

// 键盘弹出会调用
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 1.获取键盘frame
    CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.获取键盘弹出时长
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    // 3.修改自身的y值
    __weak JLToobar *weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        
        CGRect frame = weakSelf.frame;
        
        // 修改工具条的y值 工具条的y值=键盘的y值－工具条的高度
        frame.origin.y = endFrame.origin.y - CGRectGetHeight(frame);
        
        weakSelf.frame = frame;
        
    }];
}


/**
 子控件的布局
 */
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    
    //1.语音按钮
    CGFloat voiceX = kBtnMargin;
    CGFloat voiceY = frame.size.height-8-kBtnHW;
    _voiceBtn.frame = CGRectMake(voiceX, voiceY, kBtnHW, kBtnHW);
    
    //2.输入框
    CGFloat inputX = CGRectGetMaxX(_voiceBtn.frame)+kBtnMargin;
    CGFloat inputY = kBtnMargin;
    CGFloat inputW = (frame.size.width-inputX) - kBtnHW*2-kBtnMargin*3;
    CGFloat inputH = frame.size.height-kBtnMargin*2;
    _inputView.frame = CGRectMake(inputX, inputY, inputW, inputH);
    
    //3.表情按钮
    CGFloat emojiX = CGRectGetMaxX(_inputView.frame)+kBtnMargin;
    _emojiBtn.frame = CGRectMake(emojiX, voiceY, kBtnHW, kBtnHW);
    
    //4.添加按钮
    CGFloat addX = CGRectGetMaxX(_emojiBtn.frame)+kBtnMargin;
    _addBtn.frame = CGRectMake(addX, voiceY, kBtnHW, kBtnHW);
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
