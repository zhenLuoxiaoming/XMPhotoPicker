//
//  XMAssetsManager.h
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface XMAssetsManager : NSObject
+(NSArray <PHAsset *>*)getAssets;
+(void)getCameryPhotoWithImageSize:(CGSize)imageSize synchronous:(BOOL)synchronous complete:(void(^)(UIImage * image,NSDictionary * info,PHAsset * asset))complete;
+(void)getPhotoWithAssets:(PHAsset *)asset imageSize:(CGSize)imageSize option:(PHImageRequestOptions *)option complete:(void(^)(UIImage * image,NSDictionary * info))complete;
+(void)getPhotoWithAssets:(PHAsset *)asset imageSize:(CGSize)imageSize synchronous:(BOOL)synchronous complete:(void(^)(UIImage * image,NSDictionary * info))complete;
@end
