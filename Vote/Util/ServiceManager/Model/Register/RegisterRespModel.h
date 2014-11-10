//
//  RegisterRespModel.h
//  EmotionChaperone
//
//  Created by apple on 14-10-24.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

@interface RegisterRespModel : JSONModel

/*
 uid	用户ID	string
 telphone	手机号码	string
 hasnewmsg	是否有新的消息		int(0:没有/1有)
 */

@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *telphone;
@property (nonatomic, strong)NSString *hasnewmsg;
@end
