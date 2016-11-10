//
//  HYGlobal.h
//  HappyYoga
//
//  Created by qianjianlei on 16/11/7.
//  Copyright © 2016年 龍情雪心. All rights reserved.
//

#ifndef HYGlobal_h
#define HYGlobal_h

//notification name
#define HY_NOTIFICATION_WIZARD_DISMISSED @"com.happyyoga.notification.wizard.dismissed"
#define HY_NOTIFICATION_LOGIN_DISMISSED @"com.happyyoga.notification.login.dismissed"
#define HY_NOTIFICATION_USER_SIGNOUT @"com.happyyoga.notification.signout.dismissed"

//App default colro
#define YKT_SYS_APP_BLUE  [UIColor colorWithRed:17.0/255.0 green:184.0/255.0 blue:246.0/255.0 alpha:1.0]
//RGB颜色
#define HYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//随机色
#define HYRandomColor YBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))


//App testLog
#ifdef DEBUG    //开发测试
#define HYLog(...)  NSLog(__VA_ARGS__)
#else           //发布
#define HYLog(...)
#endif

#define YKT_ALERT_BTN_OK @"确认"
//first use
#define HY_APP_FIRST_USED @"com.happyyoga.app.firstUsed"
#define HY_APP_LOGIN_USERNAME @"com.happyyoga.app.userName"
#define HY_APP_LOGIN_PWD @"com.happyyoga.app.loginPwd"

//wizard
#define HYNewfeatureCount 4

//short message
#define API_MESSAGE_LIST @"sms/list.htm"
#define API_MESSAGE_DIALOG @"sms/detail.htm"
#define API_MESSAGE_RELATION @"sms/relation.htm"


#define HY_API_SERVER_PREFIX @"http://124.160.63.237:81/ykt-work-server/"
#define HY_API_RETURN_SUCCESS 1






//  1.直接呼叫   2.通讯录外呼     3.通话记录外呼    4.短信记录外呼
typedef enum {
    kCallDirect=1,
    kCallAddressBook,
    kCallCallRecord,
    kCallMessageRecord
}CallBindingType;

#endif /* HYGlobal_h */
