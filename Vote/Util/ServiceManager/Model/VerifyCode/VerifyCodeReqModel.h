//
//  VerifyCodeReqModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface VerifyCodeReqModel : JSONModel

/*
telphone	手机号码	-
type	[reg]/[reset](注册/找回)
 */

@property (nonatomic, strong)NSString *telphone;
@property (nonatomic, strong)NSString *type;
@end
