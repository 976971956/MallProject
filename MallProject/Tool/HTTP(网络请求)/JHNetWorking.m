//
//  JHNetWorking.m
//  JHProjectDemo
//
//  Created by 李江湖 on 2018/11/23.
//  Copyright © 2018年 李江湖. All rights reserved.
//

#import "JHNetWorking.h"

@interface JHNetWorking()
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, copy)AFHttpSuccessfulBlock successBlock;
@property (nonatomic, copy)AFHttpErrorBlock failureBlock;
@property (nonatomic, assign) BOOL showHUD;
@property (nonatomic, assign) JHNetworkRequstType httpType;
@end
@implementation JHNetWorking

+ (JHNetWorking *)shareInstance //获取网络请求单例
{
    static JHNetWorking *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (helper == nil)
        {
            helper = [[JHNetWorking alloc] init];
            helper.showHUD = YES;
        }
    });
    return helper;
}

#pragma makr - 开始监听网络连接
+ (void)startMonitoringNetWoringType
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                [JHNetWorking shareInstance].networkStats = StatusUnknown;
                
                break;
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络");
                [JHNetWorking shareInstance].networkStats=StatusNotReachable;
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                [JHNetWorking shareInstance].networkStats=StatusReachableViaWWAN;
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"wifi");
                [JHNetWorking shareInstance].networkStats=StatusReachableViaWiFi;
                break;
        }
    }];
    [mgr startMonitoring];
}

- (JHNetWorking *(^)(NSString *, NSDictionary *))post {
    return ^(NSString *url,NSDictionary *parm){
        self.httpType = PostType;
        self.url = url;
        self.parameters = parm;
        return self;
    };
}

- (JHNetWorking *(^)(NSString *, NSDictionary *))get {
    return ^(NSString *url,NSDictionary *parm){
        self.httpType = GetType;
        self.url = url;
        self.parameters = parm;
        return self;
    };
}

-(JHNetWorking *(^)(BOOL))showhud {
    return ^(BOOL showhud){
        self.showHUD = showhud;
        return self;
    };
}



- (JHNetWorking *(^)(AFHttpSuccessfulBlock))success {
    return ^(AFHttpSuccessfulBlock successfulBlock) {
        self.successBlock = successfulBlock;
        return self;
    };
}

- (JHNetWorking *(^)(AFHttpErrorBlock))failure {
    return ^(AFHttpErrorBlock faikBlock) {
        //开始请求数据
        self.failureBlock = faikBlock;
        if(self.showHUD){
            [SVProgressHUD showWithStatus:@"加载中。。。"];
        } else{
            
        }
        [self postSendRequest];
        return self;
    };
}

- (void)postSendRequest {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //默认返回JSON类型（可以不写）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    
    NSDictionary *dic = [JHNetWorking addSecurityIdentifyWithParameters:[JHNetWorking shareInstance].parameters];
    
    //设置返回类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    if([JHNetWorking shareInstance].httpType == PostType){
        [manager POST:[JHNetWorking shareInstance].url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                NSString *State = [dict objectForKey:@"State"];
                NSNumber *code = [dict objectForKey:@"code"];
                if (![State isKindOfClass:[NSNull class]]) {
                    if ([State isEqualToString:@"tokenInvalid"]||[code integerValue]==20020) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetViewSignOutNotification" object:nil];
                    }
                }
            }
            
            NSString *state = [dict objectForKey:@"State"];
            if (![NSString isPureString:state]) {
                state = @"";
            }
            NSNumber *code = [dict objectForKey:@"code"];
            if (![code isKindOfClass:[NSNumber class]]) {
                code = [NSNumber numberWithInteger:4399];
            }
            
            if ([state.lowercaseString isEqualToString:@"success"] || (code.integerValue == 200)) {
                JHError *error = [[JHError alloc] init];
                if ([NSString isPureString:dict[@"message"]]) {
                    error.message = dict[@"message"];
                } else if ([NSString isPureString:dict[@"Message"]]) {
                    error.message = dict[@"Message"];
                } else {
                    error.message = @"数据加载失败";
                }
                
                [JHNetWorking shareInstance].successBlock(dict, true, error);
            } else {
                JHError *error = [[JHError alloc] init];
                if ([NSString isPureString:dict[@"message"]]) {
                    error.message = dict[@"message"];
                } else if ([NSString isPureString:dict[@"Message"]]) {
                    error.message = dict[@"Message"];
                } else {
                    error.message = @"数据加载失败";
                }
                [JHNetWorking shareInstance].successBlock(dict, false, error);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            [JHNetWorking shareInstance].failureBlock(error);
        }];
    }else{
        [manager GET:[JHNetWorking shareInstance].url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
            if ([dict isKindOfClass:[NSDictionary class]]) {
                NSString *State = [dict objectForKey:@"State"];
                NSNumber *code = [dict objectForKey:@"code"];
                if (![State isKindOfClass:[NSNull class]]) {
                    if ([State isEqualToString:@"tokenInvalid"]||[code integerValue]==20020) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"SetViewSignOutNotification" object:nil];
                    }
                }
            }
            
            NSString *state = [dict objectForKey:@"State"];
            if (![NSString isPureString:state]) {
                state = @"";
            }
            NSNumber *code = [dict objectForKey:@"code"];
            if (![code isKindOfClass:[NSNumber class]]) {
                code = [NSNumber numberWithInteger:4399];
            }
            
            if ([state.lowercaseString isEqualToString:@"success"] || (code.integerValue == 200)) {
                JHError *error = [[JHError alloc] init];
                if ([NSString isPureString:dict[@"message"]]) {
                    error.message = dict[@"message"];
                } else if ([NSString isPureString:dict[@"Message"]]) {
                    error.message = dict[@"Message"];
                } else {
                    error.message = @"数据加载失败";
                }
                
                [JHNetWorking shareInstance].successBlock(dict, true, error);
            } else {
                JHError *error = [[JHError alloc] init];
                if ([NSString isPureString:dict[@"message"]]) {
                    error.message = dict[@"message"];
                } else if ([NSString isPureString:dict[@"Message"]]) {
                    error.message = dict[@"Message"];
                } else {
                    error.message = @"数据加载失败";
                }
                [JHNetWorking shareInstance].successBlock(dict, false, error);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD dismiss];
            [JHNetWorking shareInstance].failureBlock(error);
        }];
    }
}

#pragma mark - 增加公共参数
+ (NSDictionary *)addSecurityIdentifyWithParameters:(NSDictionary *)parameters {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSString *client_id = @"100015";
    NSString *client_pwd = @"LMCITY-a3bd3e3c84e1";
    NSString *pwdMDStr = [[client_pwd md5String] uppercaseString];
    NSString *client_secret = @"77f6a58d297a1cf4426ca6b8775c1295";
    // 时间戳
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *timestamp = [matter stringFromDate:date];
    
    NSString *temp = [NSString stringWithFormat:@"%@%@%@%@%@",client_secret,client_id,pwdMDStr,timestamp,client_secret];
    NSString *sign = [[temp md5String] uppercaseString];
    
    [dic setValue:client_id forKey:@"client_id"];
    [dic setValue:client_pwd forKey:@"client_pwd"];
    [dic setValue:timestamp forKey:@"timestamp"];
    [dic setValue:sign forKey:@"sign"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithDictionary:dic];
    return dictionary;
}

- (void)getSendRequest {
    
}

+ (void)postUrl:(NSString*)url parameters:(NSDictionary *)parameters success:(AFHttpToolSuccessBlock)successblock failure:(AFHttpToolErrorBlock)errorblock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 1.获得请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //默认返回JSON类型（可以不写）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    
    NSDictionary *dic = [self addSecurityIdentifyWithParameters:parameters];
    
    //设置返回类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSString *State = [dict objectForKey:@"State"];
            NSNumber *code = [dict objectForKey:@"code"];
            
            if (![State isKindOfClass:[NSNull class]]) {
                if ([State isEqualToString:@"tokenInvalid"]||[code integerValue]==20020) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"SetViewSignOutNotification" object:nil];
                }
            }
        }
        successblock(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        errorblock(error);
    }];
    
}

@end
