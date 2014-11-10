//
//  BaseTabbarButton.h
//  BlindDate
//
//  Created by wangyue on 14-7-25.
//
//

#import <UIKit/UIKit.h>

@interface BaseTabbarButton : UIButton

-(id)initWithFrame:(CGRect)frame;

+(id)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame font:(UIFont*)font;

@end
