//
//  LoginResponseModel.h
//  BlindDate
//
//  Created by apple on 14-6-14.
//  Copyright (c) 2014年 hongniangwang. All rights reserved.
//

#import "JSONModel.h"

/*
 uid	用户ID	string
 mainimg 	头像url	string
 images_ischeck	头像是否审核通过(1:通过,0:未通过)	string
 level	用户等级（1服务者  0普通用户）	int
 birth	出生日期(YYYY-MM-DD)	string
 nickname  	昵称	string
 gender	性别	int(0男 1女)
 hasnewmsg	是否有新的消息	int(0:没有/1有)
 province	省	string
 city	市	string
 服务者通用户
	balance	当前用户可以提现的金额	double
	phoneNumber	电话号码	Long
	message_count	新的未读消息	int
	new_order	新的未处理订单	int
	evaluation_count	新的未读评价	int
    complaint_count	新的投诉消息	int
 普用户
    phoneNumber	电话号码	Long
    gold_count	当前账户剩余陪护币	int
    message_count	新的未读消息	int

 */
@interface LoginRespModel : JSONModel
@property(nonatomic,strong)NSString *loginToken;
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *mainimg;
@property(nonatomic,strong)NSString *images_ischeck;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *birth;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *hasnewmsg;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *phoneNumber;
@property(nonatomic,strong)NSString *message_count;
//服务者通用户
@property(nonatomic,strong)NSString *balance;
@property(nonatomic,strong)NSString *theNewOrder;
@property(nonatomic,strong)NSString *evaluation_count;
@property(nonatomic,strong)NSString *complaint_count;
//普用户
@property(nonatomic,strong)NSString *gold_count;
@end








