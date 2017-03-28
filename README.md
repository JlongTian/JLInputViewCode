# JLInputViewCode
实现微信输入框的文字高度自适应效果（代码实现）
实现微信输入框效果（textView自适应文字高度），用法如下：
```objc
    // 设置文本框占位文字和字体颜色
    _inputView.placeholder = @"请输入内容";
    _inputView.placeholderColor = [UIColor lightGrayColor];
    
    //如果不需要占位文字就将placeholderHidden设置为YES
    //_inputView.placeholderHidden = YES;
    
    // 监听文本框文字高度改变
    _inputView.textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
    
        // 文本框文字高度改变会自动执行这个block，如果inputView的父视图需要随着它的高度改变而改变，那么就在这里修改高度
        
    };
    
    // 设置文本框最大行数
    _inputView.maxNumberOfLines = 4;
```
效果图：

![效果图](https://github.com/JlongTian/JLInputView/blob/master/image/show.gif)
