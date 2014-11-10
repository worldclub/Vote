//
//  VerifyCodeRespModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface VerifyCodeRespModel : JSONModel

/*
 telphone	手机号	string
 */
@property (nonatomic, strong)NSString *telphone;
@end
