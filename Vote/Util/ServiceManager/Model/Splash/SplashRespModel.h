//
//  SplashRespModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface SplashRespModel : JSONModel
/*
 screen	新的闪屏图片，为空则不需更新，图片地址数组
 newUrl	版本更新地址，为空则不需更新
 uploadCode	版本升级分类编码
 0	不升级
 1	升级
 2   强制升级
 uploadInfo	版本更新的信息
 */

@property (nonatomic, strong)NSArray *screen;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, assign)int uploadCode;
@property (nonatomic, strong)NSString *uploadInfo;
@property (nonatomic, strong)NSString *gqtime;
@end
