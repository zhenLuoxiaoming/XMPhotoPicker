//
//  XMAssetsManager.m
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "XMAssetsManager.h"
#import <UIKit/UIKit.h>

@implementation XMAssetsManager

+(NSArray <PHAsset *>*)getAssets {
    PHFetchResult *assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    NSMutableArray * array = [NSMutableArray array];
    for (PHAsset *asset in assets) {
        [array addObject:asset];
    }
    return array;
}

+(void)getCameryPhotoWithImageSize:(CGSize)imageSize synchronous:(BOOL)synchronous complete:(void(^)(UIImage * image,NSDictionary * info,PHAsset * asset))complete {
    //获取相机胶卷所有图片
    PHFetchResult *assets = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:nil];
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    //设置显示模式
    /*
     PHImageRequestOptionsResizeModeNone    //选了这个就不会管传如的size了 ，要自己控制图片的大小，建议还是选Fast
     PHImageRequestOptionsResizeModeFast    //根据传入的size，迅速加载大小相匹配(略大于或略小于)的图像
     PHImageRequestOptionsResizeModeExact    //精确的加载与传入size相匹配的图像
     */
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.synchronous = synchronous;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    for (PHAsset *asset in assets) {
        [self getPhotoWithAssets:asset imageSize:imageSize option:option complete:^(UIImage *image, NSDictionary *info) {
            if (complete) {
                complete(image,info,asset);
            }
        }];
    }
}

// 通过asset获取图片
+(void)getPhotoWithAssets:(PHAsset *)asset imageSize:(CGSize)imageSize option:(PHImageRequestOptions *)option complete:(void(^)(UIImage * image,NSDictionary * info))complete {
    if (option == nil) {
        option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeNone;
        option.synchronous = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    }
    if (imageSize.width == 0 || imageSize.height == 0) {
        imageSize = CGSizeMake(asset.pixelHeight , asset.pixelWidth);
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
    }
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (complete) {
            complete(result,info);
        }
    }];
}

// 通过asset获取图片
+(void)getPhotoWithAssets:(PHAsset *)asset imageSize:(CGSize)imageSize synchronous:(BOOL)synchronous complete:(void(^)(UIImage * image,NSDictionary * info))complete {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeNone;
    option.synchronous = synchronous;
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;

    if (imageSize.width == 0 || imageSize.height == 0) {
        imageSize = CGSizeMake(asset.pixelHeight , asset.pixelWidth);
        option.resizeMode = PHImageRequestOptionsResizeModeFast;
    }
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (complete) {
            complete(result,info);
        }
    }];
}

@end
