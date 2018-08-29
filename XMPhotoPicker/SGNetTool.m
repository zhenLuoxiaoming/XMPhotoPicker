//
//  SGNetTool.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGNetTool.h"
#import "SGBaseNetTool.h"

@implementation SGNetTool

+(id)GET_UrlString:(NSString *)urlString parameters:(NSDictionary *)params success:(XMResponseSuccess)success fail:(XMResponseFail)fail {
    
    return [SGBaseNetTool GET_UrlString:urlString parameters:params success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } fail:^(id error) {
        if (fail) {
            fail(error);
        }
    }];
}

+(id)POST_UrlString:(NSString *)url parameters:(NSDictionary *)params success:(XMResponseSuccess)success fail:(XMResponseFail)fail {
    return [SGBaseNetTool POST_UrlString:url parameters:params success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } fail:^(id error) {
        if (fail) {
            fail(error);
        }
    }];
}

+(void)cancelNetwork {
    [SGBaseNetTool cancelNetwork];
}
@end
