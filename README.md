# UITextView-Placeholder8.0up
modified the old UITextView-PlaceHolder，the old project will crash when it runs on the iOS8.0 iPhone.
# UITextView-Placeholder
a kind of class base on UITextView With custom PlaceHolder

# 思路
通过runtime关联对象方法，关联一个私有Label变量，实现占位字符串的功能

使用方法交换将TextView的font与placeholderlabel的font绑定，同时变化大小。
```
+ (void)load {
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod = class_getInstanceMethod(self, @selector(was_setFont:));
    
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
}
```

# 使用方法
直接将UITextView+Placeholder.h和UITextView+Placeholder.m拖入项目中，在需要使用TextView的控制器内导入，调用下面方法可以
```
- (void)was_setPlaceholderWithText:(NSString *)placeholder Color:(UIColor *)color;
```
* 如果有好的建议可以直接留言或者发送邮件：andysection@gmail.com

Thank you for your reading !
