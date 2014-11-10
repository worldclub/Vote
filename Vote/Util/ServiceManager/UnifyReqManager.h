//
//  UnifyReqManager.h
//  BlindDate
//
//  Created by apple on 14-9-4.
//
//

#import <Foundation/Foundation.h>

/*****************************************************************************************
 封装网络请求
 
 1.组装请求的url
 
 2.组装请求的数据
 
 解析网络返回数据
 
 *******************************************************************************************/

typedef enum
{
    DATA_NULL_ERROR = 100000,               // 空数据错误
    DATA_FORMAT_ERROR,                      // 数据格式错误
    DATA_MESSAGE_ERROR,                     // 服务器错误信息返回
    NETWORK_DISCONNECT_ERROR                // 网络连接失败
}ERROR_CODE;

typedef void(^SuccessBlock)(id responeModel);
typedef void(^FailureBlock)(NSError *error);

@interface UnifyReqManager : NSObject

- (void)clear;

// 请求
- (void)unifyReq:(id)requestModel
         success:(SuccessBlock)success
         failure:(FailureBlock)failure;
@end
