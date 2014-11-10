//
//  LYBaseLabel.h
//  Layou
//
//  Created by cydida on 14-5-14.
//  Copyright (c) 2014年 cydida. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentNone = 0,// default
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


@interface BaseLabel : UILabel
{
    @private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

- (id)initWithFrame:(CGRect)frame withTextColor:(UIColor *)textColor withFont:(UIFont *)font;

@end
