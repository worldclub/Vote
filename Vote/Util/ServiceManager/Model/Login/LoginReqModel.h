//
//  LoginRequestModel.h
//  BlindDate
//
//  Created by apple on 14-6-26.
//
//

#import "JSONModel.h"

@interface LoginReqModel : JSONModel

/*
 参数名称	说明	是否必填
 nickname	昵称、手机号	-
 password	密码	-
 IMIE	手机设备号	-
 fromsys	5 => 'ios手机客户端'7 => 'android手机客户端
 */

@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *fromsys;
@property(nonatomic,strong)NSString *IMIE;

@end
