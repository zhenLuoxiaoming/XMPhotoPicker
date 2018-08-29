//
//  SGNetStatusManager.h
//  SGFreamwoke
//
//  Created by 罗晓明 on 2018/8/28.
//  Copyright © 2018年 Rowling. All rights reserved.
//

/**
 * 用法： 用该类的单例去监听网络状态。通过netChangeBlock 来处理网络变化问题
 */

#import <Foundation/Foundation.h>
typedef enum {
    NONet,    // 没有网络
    WiFiNet,  // wifi
    OtherNet, // 其他
}NetType;
@interface SGNetStatusManager : NSObject
/**
 * 单例
 */
+(instancetype)shareInstance;
/**
 * 网络状态
 */
@property(nonatomic, assign) NetType netType;
/**
 * 网络状态描述字符串
 */
@property(nonatomic, strong) NSString *netTypeString;
/**
 * 网络状态变更回掉block
 */
@property(nonatomic,strong) void(^netChangeBlock)(NetType netType);
/**
 * 开始监听
 */
-(NetType)startMonitoringNet;
@end
