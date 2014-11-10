//
//  LYBaseLabel.m
//  Layou
//
//  Created by cydida on 14-5-14.
//  Copyright (c) 2014年 cydida. All rights reserved.
//

#import "BaseLabel.h"
#import "Global.h"

@implementation BaseLabel

/***
 从 storyboard 中加载
 **/
-(void)awakeFromNib
{
    _verticalAlignment = VerticalAlignmentMiddle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment   = NSTextAlignmentLeft;
        self.lineBreakMode   = NSLineBreakByTruncatingTail;
        _verticalAlignment = VerticalAlignmentNone;
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame withTextColor:(UIColor *)textColor withFont:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment   = NSTextAlignmentLeft;
        self.lineBreakMode   = NSLineBreakByTruncatingTail;
        _verticalAlignment = VerticalAlignmentNone;
        if (textColor)
        {
            self.textColor = textColor;
        }
        else
        {
            //self.textColor = [UIColor getColorByLong:0xadadad];
        }
        if (font)
        {
            self.font = font;
        }
        else
        {
            self.font = HELETICA_BOLD_SIZE(12);
        }
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentNone:
            break;
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect
{
    CGRect actualRect = requestedRect;
    if (_verticalAlignment != VerticalAlignmentNone) {
        actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    }
    [super drawTextInRect:actualRect];
}

@end
