//
//  XMPhotoPickerListViewController.h
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMPhotoPickerListViewController : UIViewController
@property(nonatomic,assign)NSInteger  pickCount;
@property(nonatomic,strong)void(^okbuttonClick)(NSArray <UIImage *>* imageArray);
@end
