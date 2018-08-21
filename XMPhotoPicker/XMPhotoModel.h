//
//  PhotoModel.h
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface XMPhotoModel : NSObject
@property(nonatomic,strong) UIImage * thumbnailImage;
@property(nonatomic,strong)PHAsset *asset;
@property(nonatomic,assign)BOOL  isSelected;

@end
