//
//  LYBaseButton.m
//  Layou
//
//  Created by cydida on 14-4-24.
//  Copyright (c) 2014年 cydida. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.exclusiveTouch = YES;
    }
    return self;
}

-(id)init
{
    if (self = [super init])
    {
        self.exclusiveTouch = YES;
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    UIButton *btn = [super buttonWithType:buttonType];
    if (btn)
    {
        btn.exclusiveTouch = YES;
    }
    return btn;
}

@end
