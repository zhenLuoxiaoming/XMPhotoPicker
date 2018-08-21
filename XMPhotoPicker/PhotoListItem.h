//
//  PhotoListItem.h
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoListItem : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@end
