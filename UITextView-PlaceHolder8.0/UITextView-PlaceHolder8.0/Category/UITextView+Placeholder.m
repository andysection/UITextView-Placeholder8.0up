//
//  UITextView+Placeholder.m

#import "UITextView+Placeholder.h"
#import <objc/runtime.h>

static const char *kPlaceholderKey = "kPlaceholderKey";
static const char *kPlaceholderLabelKey = "kPlaceholderLabelKey";

@interface UITextView (PlaceholderLabel)<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation UITextView (Placeholder)

+ (void)load {
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod = class_getInstanceMethod(self, @selector(was_setFont:));
    
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
}

- (void)was_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self was_setFont:font];
    //设置占位字符串的font
    self.placeholderLabel.font = font;
    NSLog(@"%s", __func__);
}

- (UILabel *)placeholderLabel{
    return objc_getAssociatedObject(self, kPlaceholderLabelKey);
}

- (void)setPlaceholderLabel:(UILabel *)placeholderLabel{
    objc_setAssociatedObject(self, kPlaceholderLabelKey, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)placeholder{
    return objc_getAssociatedObject(self, kPlaceholderKey);
}

- (void)was_setPlaceholderWithText:(NSString *)placeholder Color:(UIColor *)color{
    objc_setAssociatedObject(self, kPlaceholderKey, placeholder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UILabel *label = [[UILabel alloc] init];
    label.text = placeholder;
    label.textColor = color;
    label.numberOfLines = 0;
    [label sizeToFit];
    [self addSubview:label];
    
    self.placeholderLabel = label;
    
    self.delegate = self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.frame = CGRectMake(5, 7.75, self.frame.size.width, self.frame.size.height);
    [self.placeholderLabel sizeToFit];
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeholderLabel.hidden = !(self.text.length == 0);
}

@end


