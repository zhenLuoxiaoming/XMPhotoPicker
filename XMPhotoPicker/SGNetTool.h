//
//  SGNetTool.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//
/**
 * 注：本类时基于SGBaseNetTool之上再封装的一层
 * 如果要在网络请求当中加入一些自定元素（参数加密，请求回掉状态码统一处理等）均在此类中进行修改。尽量不要在SGbaseNettool中做修改.
 */

#import <Foundation/Foundation.h>
/*! 定义请求成功的block */
typedef void( ^ XMResponseSuccess)(id responseObject);
/*! 定义请求失败的block */
typedef void( ^ XMResponseFail)(id error);
/*! 定义下载进度block */
typedef void( ^ XMDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);
/*! 定义上传进度block */
typedef void( ^ XMUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);
@interface SGNetTool : NSObject
/**
 *  GET请求
 *
 */
+ (id)GET_UrlString:(NSString *)urlString
         parameters:(NSDictionary *)params
            success:(XMResponseSuccess)success
               fail:(XMResponseFail)fail;

/**
 *  POST请求
 */
+ (id)POST_UrlString:(NSString *)url
          parameters:(NSDictionary *)params
             success:(XMResponseSuccess)success
                fail:(XMResponseFail)fail;

/**
 * 取消参数
 */
+ (void)cancelNetwork;
@end
