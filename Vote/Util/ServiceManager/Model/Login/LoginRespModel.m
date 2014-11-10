//
//  LoginResponseModel.m
//  BlindDate
//
//  Created by apple on 14-6-14.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "LoginRespModel.h"

@implementation LoginRespModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"new_order": @"theNewOrder"}];
}
@end
