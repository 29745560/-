//
//  HTTPManager.h
//  GNNH
//
//  Created by WYS on 16/9/2.
//  Copyright © 2016年 WYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@interface HTTPManager : NSObject

/*  网络请求 解析  */
+(void)publicRequest:(NSString *)URLStr parametersDictionary:(NSMutableDictionary *)parDic completion:(void(^)(NSDictionary *))blockDataDic;


/* 下载文件  */
+(AFHTTPRequestOperation *)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName;


/*  检查网络  */
+(void)checkNetWork:(void(^)(NSInteger))blockState;

@end
