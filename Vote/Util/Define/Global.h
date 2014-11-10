//
//  includeHFile.h
//  GYLouShi
//
//  Created by guanying on 14-1-10.
//  Copyright (c) 2014年 wangshuai. All rights reserved.
//

#ifndef _GLOBAL_
#define _GLOBAL_

//=======================================统计===================================================


//=======================================性别===================================================
// 男性
#define     MAN_TYPE            (@"0")
// 女性
#define     WOMAN_TYPE          (@"1")

//=======================================内购====================================================

//=======================================通知====================================================

//=======================================字体====================================================
#define HELETICA_BOLD_SIZE(font)   ([UIFont fontWithName:@"Helvetica-Bold" size:font])
#define HELETICA_SIZE(font)        ([UIFont fontWithName:@"Helvetica" size:font])

//=======================================颜色======================================================
#define COLOR_PLACE_HOLDER         ([UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1.0f])
#define BACKGROUND_COLOR           ([UIColor colorWithRed:240/255.0f green:237/255.0f blue:245/255.0f alpha:1.0f])
#define MAIN_BLUE_COLOR            ([UIColor colorWithRed:147/255.0f green:64/255.0f blue:196/255.0f alpha:1.0f])


//=======================================设备相关=================================================
#define BD_DEBUG                                (0)
#define Screen_height                           [[UIScreen mainScreen] bounds].size.height
#define Screen_width                            [[UIScreen mainScreen] bounds].size.width
#define IOS7                                    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8                                    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define NAV_HEIGHT                              (64)
#define DOCUMENTS_PATH                          [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()]
#define RESOURCE_PATH(fname, ftype)             [[NSBundle mainBundle] pathForResource:fname ofType:ftype]

//===================================================日志==================================================================
#define __DEBUG__
#ifdef __DEBUG__

    #define UI_DUBUG_INFO                 (@"\n<<UI层调试信息>>:")
    #define SERVICE_MANAGER_DUBUG_INFO    (@"\n<<Manager层调试信息>>:")
    #define LOG_FUNCTION                  ([[NSString stringWithCString:__FUNCTION__ encoding:NSUTF8StringEncoding]\
                                            lastPathComponent])

    #define LOG_FILE                     ([[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding]lastPathComponent])

    #define DEBUG_BODY                   [NSString stringWithFormat:@"FILE:%@\nFUNCTION:%@\nFILE:%d\n",LOG_FILE,LOG_FUNCTION,\
                                          __LINE__]

    #define UI_LOG(...)                   NSLog(@"\n%@\n%@",UI_DUBUG_INFO,DEBUG_BODY);NSLog(__VA_ARGS__);

    #define SERVICE_LOG(...)              NSLog(@"\n%@\n%@",SERVICE_MANAGER_DUBUG_INFO,DEBUG_BODY);NSLog(__VA_ARGS__);

#else

    #define        UI_LOG(...)
    #define        SERVICE_LOG(...)
    #define        SERVICE_CENTER_LOG(...)

#endif


#endif












