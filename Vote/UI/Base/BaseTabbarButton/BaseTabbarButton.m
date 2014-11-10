//
//  BaseTabbarButton.m
//  BlindDate
//
//  Created by wangyue on 14-7-25.
//
//

#import "BaseTabbarButton.h"
#import "Global.h"
#define kImageRatio  0.52

@implementation BaseTabbarButton

+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame font:(UIFont*)font
{
    UIButton *button = [super buttonWithType:buttonType];
    if (button) {
        
        button.frame = frame;
        
        // 设置title属性
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = font;
        // 设置图片属性
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.adjustsImageWhenHighlighted = NO;
        
        button.exclusiveTouch = YES;
        
    }
    return button;
}


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = HELETICA_SIZE(12);
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        
    }
    return self;
}

#pragma mark - 重写父类的方法
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kImageRatio - 2;
    CGFloat titleHeight = contentRect.size.height - titleY;
    
    return CGRectMake(4, titleY + 2, CGRectGetWidth(contentRect) - 8, titleHeight);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
//    CGRect rect = [super imageRectForContentRect:contentRect];
    CGFloat XY = contentRect.size.height * kImageRatio;
    return CGRectMake((CGRectGetWidth(contentRect) - XY) / 2, 8, XY, XY);
}

@end
