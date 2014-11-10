//
//  SplashRespModel.m
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "SplashRespModel.h"

@implementation SplashRespModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"newUrl": @"url"}];
}
@end
