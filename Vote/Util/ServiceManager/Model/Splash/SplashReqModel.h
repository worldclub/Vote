//
//  SplashReqModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface SplashReqModel : JSONModel
/*
 r_version	客户端版本	-
 fromsys	5 => 'ios手机客户端'7 => 'android手机客户端	-
 */

@property (nonatomic, strong)NSString *r_version;
@property (nonatomic, strong)NSString *fromsys;
@end
