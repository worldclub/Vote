//
//  UnifyReqManager.m
//  BlindDate
//
//  Created by apple on 14-9-4.
//
//

#import "UnifyReqManager.h"
#import "RequstURL.h"
#import <objc/runtime.h>
#import "Global.h"
#import "DefineString.h"

#import "AFNetworking.h"
#import "NSData+ImageContentType.h"
#import "JSONModel.h"
#import "AppDelegate.h"

@interface UnifyReqManager ()

@property(nonatomic,copy)SuccessBlock successBlock;
@property(nonatomic,copy)FailureBlock failureBlock;
@property(nonatomic,assign)JSONModel *requestModel;
@property(nonatomic,strong)JSONModel *responseModel;
@property(nonatomic,strong)NSString *reqBodyClassName;
@property(nonatomic,strong)NSString *requestURL;
@end

@implementation UnifyReqManager

#define     CODE                    (@"code")
#define     MSG                     (@"msg")
#define     INFO                    (@"info")
#define     LIST                    (@"list")
#define     SERVICE_DATA_ERROR      (@"服务器返回数据异常")

#pragma mark -
#pragma mark 手动清除网络请求
- (void)clear
{
    self.successBlock = nil;
    self.failureBlock = nil;
}

#pragma mark -
#pragma mark 根据当前的请求数据封装网络请求数据（url+请求类型等）
- (void)unifyReq:(id)requestModel
         success:(SuccessBlock)success
         failure:(FailureBlock)failure
{
    self.requestModel = requestModel;
    self.successBlock = success;
    self.failureBlock = failure;
    
    // 保存请求类的名称
    self.reqBodyClassName = NSStringFromClass([requestModel class]);
    // 获取请求url
    self.requestURL = [RequstURL getRequestURL:self.reqBodyClassName];

    SERVICE_LOG(@"当前请求URL:%@\n",self.requestURL);
    SERVICE_LOG(@"当前请求体:%@\n",[self.requestModel toDictionary]);
    
    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(myDelegate.isNetworkReachability)
    {
        [self sendHttpRequsetData];
    }
}

- (void)sendHttpRequsetData
{
    //开启网络转圈
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:self.requestURL parameters:[self.requestModel toDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self dealWithSuccessResult:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self dealWithFailResult:error];
    }];
    
//    //创建请求
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:self.requestURL parameters:self.requestModel constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         
//     }
//          success:^(NSURLSessionDataTask *task, id responseObject)
//     {
//         // 停止网络转圈
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self dealWithSuccessResult:responseObject];
//     }
//          failure:^(NSURLSessionDataTask *operation, NSError *error)
//     {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self dealWithFailResult:error];
//     }];
    
}

#pragma mark -
#pragma makr 网络请求成功处理
-(void)dealWithSuccessResult:(id)obj
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    SERVICE_LOG(@"当前请求返回:%@\n",dic);
    
    if(dic == nil || [dic count] == 0)
    {
        [self handleError:SERVICE_DATA_ERROR code:DATA_NULL_ERROR userInfo:nil];
        
        return;
    }
    
    // 获取返回类的名称
    NSArray *arr = [self.reqBodyClassName componentsSeparatedByString:@"ReqModel"];
    NSMutableString *respName = [[NSMutableString alloc]init];
    if (arr.count > 0)
    {
        [respName appendString:[arr objectAtIndex:0]];
    }
    
    [respName appendString:@"RespModel"];
    
    Class respClass = NSClassFromString(respName);

    //解析数据
    if ([[dic allKeys]containsObject:CODE] && [NSNull null]!= [dic objectForKey:CODE])
    {
        int code =  [[dic objectForKey:CODE] intValue];
        // 接口调用成功
        if (1 == code)
        {
            // 根据返回类解析对应的数据
            if ([[dic allKeys]containsObject:INFO] && [NSNull null]!= [dic objectForKey:INFO])
            {
                NSError* err = nil;
                self.responseModel = [[respClass alloc] initWithDictionary:[dic objectForKey:INFO] error:&err];
                
                if(err)
                {
                    [self handleError:SERVICE_DATA_ERROR code:DATA_FORMAT_ERROR userInfo:nil];
                     return;
                }
                
                if(!self.responseModel)
                {
                    [self handleError:SERVICE_DATA_ERROR code:DATA_FORMAT_ERROR userInfo:nil];
                    
                    return;
                }
            }
            else if(![[dic allKeys]containsObject:INFO])
            {
                [self handleError:SERVICE_DATA_ERROR code:DATA_FORMAT_ERROR userInfo:nil];
                
                return;
            }
        }
        else if (0 == code)
        {
            if ([[dic allKeys]containsObject:MSG] && [NSNull null]!= [dic objectForKey:MSG])
            {
                NSString *msg =  [dic objectForKey:MSG];
                
                [self handleError:msg code:DATA_MESSAGE_ERROR userInfo:nil];
            }
            else
            {
                [self handleError:SERVICE_DATA_ERROR code:DATA_FORMAT_ERROR userInfo:nil];
            }
            
            return;
        }
        
        // 成功返回UI处理
        if (self.successBlock)
        {
            self.successBlock(self.responseModel);
            self.successBlock = nil;
        }
    }
    else
    {
        [self handleError:SERVICE_DATA_ERROR code:DATA_FORMAT_ERROR userInfo:nil];
    }

}

#pragma mark -
#pragma mark 网络请求失败处理
-(void)dealWithFailResult:(NSError *)error
{
    SERVICE_LOG(@"【失败】返回数据:%@\n",[error localizedDescription]);
    
    NSString *domain = @"";
    if (error.code)
    {
        switch (error.code)
        {
            case NSURLErrorUnknown:
            {
                domain = @"未知错误";
                break;
            }
            case NSURLErrorUnsupportedURL:
            {
                domain = @"URL格式有误";
                break;
            }
            case NSURLErrorCannotFindHost:
            {
                domain = @"服务器未响应";
                break;
            }
            case NSURLErrorTimedOut:
            {
                domain = @"连接超时";
                break;
            }
            case NSURLErrorNotConnectedToInternet:
            {
                domain = @"网络连接异常";
                break;
            }
            case NSURLErrorBadServerResponse:
            {
                domain = @"服务器响应错误";
                break;
            }
            default:
            {
                domain = @"网络连接异常";
                break;
            }
        }
    }
    
    [self handleError:domain code:error.code userInfo:error.userInfo];
}

- (void)handleError:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict
{
    NSError *e = [NSError errorWithDomain:domain code:code userInfo:dict];
    
    if (self.failureBlock)
    {
        self.failureBlock(e);
        self.failureBlock = nil;
    }
}

@end
