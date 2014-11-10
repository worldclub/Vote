//
//  RequstURL.m
//  BlindDate
//
//  Created by apple on 14-8-19.
//
//

#import "RequstURL.h"
#import <objc/runtime.h>
#import "Global.h"

@interface  RequstURL()

+(NSString *)getReqHostTestType;

+(NSString *)getReqHostRealType;

@end

@implementation RequstURL

+(NSString *)getReqHostTestType
{
    return @"http://192.168.1.130/qgph";
}

+(NSString *)getReqHostRealType
{
    return @"http://192.168.1.130/qgph";
}

+(NSString *)getRequestURL:(NSString *)modelName
{
    NSDictionary *requestDic = @{@"LoginReqModel": @"/Login/index",
                                 @"RegisterReqModel": @"/Register/reg",
                                 @"VerifyCodeReqModel": @"/Register/getTelCode",
                                 @"SplashReqModel": @"/Register/splashScreen"
                                 };
    
    NSMutableString *url = [[NSMutableString alloc] initWithString:[self getReqHostRealType]];
    
    if (modelName)
    {
        [url appendString:[requestDic objectForKey:modelName]];
    }
    return url;
}

@end
