//
//  BaseTextView.m
//  BlindDate
//
//  Created by apple on 14-7-6.
//
//

#import "BaseTextView.h"

@implementation BaseTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -
#pragma mark 禁用TextField的拷贝、粘贴等菜单
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

@end
