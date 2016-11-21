//
//  HTTPManager.m
//  GNNH
//
//  Created by WYS on 16/9/2.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager

#pragma mark - 网络请求 解析
+(void)publicRequest:(NSString *)URLStr parametersDictionary:(NSMutableDictionary *)parDic completion:(void(^)(NSDictionary *))blockDataDic
{
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [mgr POST:URLStr parameters:parDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString * result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData * jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        blockDataDic(dic);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error){
       
        NSLog(@"网络请求 错误信息:%@",error);
    }];
}


#pragma mark - 下载文件
+(AFHTTPRequestOperation *)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    
    if ([fileManager fileExistsAtPath:fileName])
    {
        return 0;
    }
    else
    {
        if (![fileManager fileExistsAtPath:aSavePath])
        {
            BOOL isCreate = [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            NSLog(@"创建文件存储目录 ---> %@",isCreate == YES ?@"成功":@"失败");
        }
        
        NSURL * url = [NSURL URLWithString:aUrl];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream = [NSInputStream inputStreamWithURL:url];
        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        [operation start];
        
        return operation;
    }
}


#pragma mark - 检查网络
+(void)checkNetWork:(void(^)(NSInteger))blockState
{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status)
        {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"未连接");
                blockState(0);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                blockState(1);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                blockState(2);
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络错误");
                blockState(-1);
                break;
        }
    }];
}

@end
