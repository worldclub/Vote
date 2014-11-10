//
//  BaseView.m
//  BlindDate
//
//  Created by apple on 14-7-2.
//
//

#import "BaseView.h"

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 禁用多点触摸
        self.multipleTouchEnabled = NO;
        self.exclusiveTouch = YES;
        // 其他默认设置
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
