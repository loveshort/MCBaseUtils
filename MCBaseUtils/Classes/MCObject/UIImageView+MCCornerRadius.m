//
//  UIImageView+MCCornerRadius.m
//  MCBaseUtils
//
//  Created by mingci on 2021/11/4.
//

#import "UIImageView+MCCornerRadius.h"
#import <objc/runtime.h>

const char kProcessedImage;

@interface UIImageView ()

@property (nonatomic,assign) CGFloat mcRadius;
@property (nonatomic,assign) UIRectCorner roundingCorners;
@property (nonatomic,assign) CGFloat mcBorderWidth;
@property (nonatomic,strong) UIColor *mcBorderColor;
@property (nonatomic,assign) BOOL mcHadAddObserver;
@property (nonatomic,assign) BOOL mcIsRounding;

@end

@implementation UIImageView (MCCornerRadius)

- (instancetype)initWithRoundingRectImageView {
    self = [super init];
    if (self) {
        [self mc_cornerRadiusRoundingRect];
    }
    return self;
}

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self = [super init];
    if (self) {
        [self mc_cornerRadiusAdvance:cornerRadius rectCornerType:rectCornerType];
    }
    return self;
}

- (void)mc_attachBorderWidth:(CGFloat)width color:(UIColor *)color {
    self.mcBorderWidth = width;
    self.mcBorderColor = color;
}

- (void)mc_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

- (void)mc_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType backgroundColor:(UIColor *)backgroundColor {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCornerType cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [backgroundColor setFill];
    [backgroundRect fill];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

- (void)mc_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType {
    self.mcRadius = cornerRadius;
    self.roundingCorners = rectCornerType;
    self.mcIsRounding = NO;
    if (!self.mcHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.mcHadAddObserver = YES;
    }
    
    [self layoutIfNeeded];
}

- (void)mc_cornerRadiusRoundingRect {
    self.mcIsRounding = YES;
    if (!self.mcHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.mcHadAddObserver = YES;
    }
   
    [self layoutIfNeeded];
}

#pragma mark - Private
- (void)drawBorder:(UIBezierPath *)path {
    if (0 != self.mcBorderWidth && nil != self.mcBorderColor) {
        [path setLineWidth:2 * self.mcBorderWidth];
        [self.mcBorderColor setStroke];
        [path stroke];
    }
}

- (void)mc_dealloc {
    if (self.mcHadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
    [self mc_dealloc];
}

- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleLayoutSubviews];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}

+ (void)swizzleDealloc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:NSSelectorFromString(@"dealloc") anotherMethod:@selector(mc_dealloc)];
    });
}

+ (void)swizzleLayoutSubviews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(mc_LayoutSubviews)];
    });
}

- (void)mc_LayoutSubviews {
    [self mc_LayoutSubviews];
    if (self.mcIsRounding) {
        [self mc_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
    } else if (0 != self.mcRadius && 0 != self.roundingCorners && nil != self.image) {
        [self mc_cornerRadiusWithImage:self.image cornerRadius:self.mcRadius rectCornerType:self.roundingCorners];
    }
}

#pragma mark - KVO for.image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &kProcessedImage) intValue] == 1) {
            return;
        }
        [self validateFrame];
        if (self.mcIsRounding) {
            [self mc_cornerRadiusWithImage:newImage cornerRadius:self.frame.size.width/2 rectCornerType:UIRectCornerAllCorners];
        } else if (0 != self.mcRadius && 0 != self.roundingCorners && nil != self.image) {
            [self mc_cornerRadiusWithImage:newImage cornerRadius:self.mcRadius rectCornerType:self.roundingCorners];
        }
    }
}





#pragma mark property
- (CGFloat)mcBorderWidth{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMcBorderWidth:(CGFloat)mcBorderWidth{
    objc_setAssociatedObject(self, @selector(mcBorderWidth), @(mcBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIColor *)mcBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setMcBorderColor:(UIColor *)mcBorderColor {
    objc_setAssociatedObject(self, @selector(mcBorderColor), mcBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)mcHadAddObserver {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (void)setMcHadAddObserver:(BOOL)mcHadAddObserver{
    objc_setAssociatedObject(self, @selector(mcHadAddObserver), @(mcHadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)mcIsRounding {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}


- (void)setMcIsRounding:(BOOL)mcIsRounding{
    objc_setAssociatedObject(self, @selector(mcIsRounding), @(mcIsRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIRectCorner)roundingCorners {
    return [objc_getAssociatedObject(self, _cmd) unsignedLongValue];
}


- (void)setRoundingCorners:(UIRectCorner)roundingCorners {
    objc_setAssociatedObject(self, @selector(roundingCorners), @(roundingCorners), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)mcRadius{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


- (void)setMcRadius:(CGFloat)mcRadius{
    objc_setAssociatedObject(self, @selector(mcRadius), @(mcRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
