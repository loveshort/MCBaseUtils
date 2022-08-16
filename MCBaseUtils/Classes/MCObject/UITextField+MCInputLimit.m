//
//  UITextField+MCInputLimit.m
//  MCBaseUtils
//
//  Created by mingci on 2021/12/7.
//

#import "UITextField+MCInputLimit.h"
#import <objc/runtime.h>

static const void *kMCTextFieldInputLimitMaxLength = &kMCTextFieldInputLimitMaxLength;

@implementation UITextField (MCInputLimit)

- (NSInteger)mc_maxLength {
    return [objc_getAssociatedObject(self, kMCTextFieldInputLimitMaxLength) integerValue];
}

- (void)setMc_maxLength:(NSInteger)mc_maxLength{
    objc_setAssociatedObject(self, kMCTextFieldInputLimitMaxLength, @(mc_maxLength), OBJC_ASSOCIATION_ASSIGN);
    
    [self addTarget:self action:@selector(mc_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}





- (void)mc_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if ((!position || !selectedRange) && (self.mc_maxLength > 0 && toBeString.length > self.mc_maxLength)) {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.mc_maxLength];
        
        if (rangeIndex.length == 1) {
            self.text = [toBeString substringToIndex:self.mc_maxLength];
        }else {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.mc_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.mc_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
        
    }
    
    
}

@end
