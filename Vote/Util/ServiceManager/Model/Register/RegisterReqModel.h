//
//  RegisterReqModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface RegisterReqModel : JSONModel
/*
 telphone	手机号	-
 code	手机验证码	-
 level	用户级别(1是服务者，0是普通用户)
 sex	性别(1是女，0是男)	-
 nickname	昵称(非空，长度最长为12)	-
 pwd	密码（非空）	-
 fromsys	5 => 'ios手机客户端'7 => 'android手机客户端	-
 IMIE	手机设备号	-
 */
@property (nonatomic, strong)NSString *telphone;
@property (nonatomic, strong)NSString *code;
@property (nonatomic, strong)NSString *level;
@property (nonatomic, strong)NSString *sex;
@property (nonatomic, strong)NSString *pwd;
@property (nonatomic, strong)NSString *nickname;
@property (nonatomic, strong)NSString *fromsys;
@property (nonatomic, strong)NSString *IMIE;
@end
