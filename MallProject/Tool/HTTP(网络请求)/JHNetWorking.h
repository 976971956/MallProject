//
//  JHNetWorking.h
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MBProgressHUD.h"
#import "NSString+Category.h"
#import "JHError.h"
typedef NS_ENUM(NSInteger, JHNetworkStatus) {
    StatusUnknown           = -1, //未知网络
    StatusNotReachable      = 0,    //没有网络
    StatusReachableViaWWAN  = 1,    //手机自带网络
    StatusReachableViaWiFi  = 2     //wifi
};

typedef NS_ENUM(NSInteger, JHNetworkRequstType) {
    GetType      = 0,    //get
    PostType  = 1,    //post
};
typedef void(^AFHttpSuccessfulBlock)(NSDictionary *dict, BOOL successful, JHError *error);
typedef void(^AFHttpErrorBlock)(NSError *error);

typedef void(^AFHttpToolSuccessBlock)(NSDictionary *dict);
typedef void(^AFHttpToolErrorBlock)(NSError *error);

@interface JHNetWorking : NSObject
+ (JHNetWorking *)shareInstance;

/**
 *  获取网络状态
 */
@property (nonatomic,assign) JHNetworkStatus networkStats;
//开始监听网络类型
+ (void)startMonitoringNetWoringType;

- (JHNetWorking *(^)(NSString *url, NSDictionary *parameters))get;
- (JHNetWorking *(^)(NSString *url, NSDictionary *parameters))post;
- (JHNetWorking *(^)(BOOL showhud))showhud;

- (JHNetWorking *(^)(AFHttpSuccessfulBlock successBlock))success;
- (JHNetWorking *(^)(AFHttpErrorBlock failureBlock))failure;

+ (void)postUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(AFHttpToolSuccessBlock)successblock failure:(AFHttpToolErrorBlock)errorblock;
@end
