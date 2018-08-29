//
//  SGNetStatusManager.m
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "SGNetStatusManager.h"
#import "AFNetworking.h"

@implementation SGNetStatusManager
+(instancetype)shareInstance {
    static SGNetStatusManager * manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SGNetStatusManager alloc]init];
    });
    return manager;
}

- (NetType)startMonitoringNet
{
    AFNetworkReachabilityManager* mgr =
    [AFNetworkReachabilityManager sharedManager];
    [mgr startMonitoring];
    __weak typeof(self)weakSelf = self;
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                weakSelf.netType = WiFiNet;
                weakSelf.netTypeString = @"WIFI";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                weakSelf.netType = OtherNet;
                weakSelf.netTypeString = @"2G/3G/4G";
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                weakSelf.netType = NONet;
                weakSelf.netTypeString = @"网络已断开";
                //            [[SDWebImageManager sharedManager] cancelAll];
                break;
            case AFNetworkReachabilityStatusUnknown:
                weakSelf.netType = NONet;
                weakSelf.netTypeString = @"其他情况";
                break;
            default:
                break;
        }
    }];
    return self.netType;
}

-(void)setNetType:(NetType)netType {
    _netType = netType;
    if (self.netChangeBlock) {
        self.netChangeBlock(netType);
    }
}
@end
