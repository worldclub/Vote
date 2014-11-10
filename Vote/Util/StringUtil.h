//
//  StringUtil.h
//  EmotionChaperone
//
//  Created by apple on 14/10/21.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isPasswordString:(NSString*)pwd;
@end
