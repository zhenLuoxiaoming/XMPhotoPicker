//
//  XMPhotoPickerListViewController.m
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "XMPhotoPickerListViewController.h"
#import "PhotoListItem.h"
#import "XMPhotoModel.h"
#import "XMAssetsManager.h"
#import <Photos/Photos.h>
#define XMS_H     [UIScreen mainScreen].bounds.size.height
#define XMS_w     [UIScreen mainScreen].bounds.size.width
#define itemW     ((XMS_w - 6)/ 4)
#define TabBarH     ([UIScreen mainScreen].bounds.size.height >= 811.0 ? 34.0 : 0.0)

@interface XMPhotoPickerListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView * collectionView;
@property (weak, nonatomic) IBOutlet UIView *collectionContentView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(nonatomic,strong) NSMutableArray <XMPhotoModel *>* photoArray;
@property(nonatomic,strong) NSMutableArray <XMPhotoModel *>* selectArray;
@end

@implementation XMPhotoPickerListViewController

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * laout = [UICollectionViewFlowLayout new];;
        laout.itemSize = CGSizeMake(itemW, itemW);
        laout.minimumLineSpacing = 2;
        laout.minimumInteritemSpacing = 2;
        laout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:laout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoListItem class]) bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}

-(NSMutableArray<XMPhotoModel *> *)selectArray {
    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}

-(NSMutableArray<XMPhotoModel *> *)photoArray {
    if (_photoArray == nil) {
        _photoArray = [[NSMutableArray alloc]init];
    }
    return _photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self imageShow];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame =  self.collectionContentView.bounds;

}

-(void)setUI {
    self.title = @"照片库";
    // collectionView
    [self.collectionContentView addSubview:self.collectionView];
    [self countRefresh];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
}

-(void)goBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma -mark:collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoListItem * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    XMPhotoModel * model = self.photoArray[indexPath.row];
    [XMAssetsManager getPhotoWithAssets:model.asset imageSize:CGSizeMake(itemW * 2, itemW * 2) synchronous:NO complete:^(UIImage *image, NSDictionary *info) {
        cell.backImageView.image = image;
    }];
    cell.selectImageView.hidden = !model.isSelected;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMPhotoModel * model = self.photoArray[indexPath.row];
    if ([self.selectArray containsObject:model]) {
        [self.selectArray removeObject:model];
    } else {
        if (self.selectArray.count >= self.pickCount) {
            NSLog(@"已经到达最大值了");
            [self showMessage];
            return;
        }
        [self.selectArray addObject:model];
    }
    model.isSelected = !model.isSelected;
    [self countRefresh];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

-(void)showMessage {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多只能选择%ld张",self.pickCount] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma -mark:获取相册所有图片
// 展示图片
-(void)imageShow {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self getPhotoData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    });
}

-(void)getPhotoData {
//    [XMAssetsManager getCameryPhotoWithImageSize:CGSizeMake(itemW * 2, itemW * 2) synchronous:YES complete:^(UIImage *image, NSDictionary *info,PHAsset * asset) {
//      XMPhotoModel * model = [XMPhotoModel new];
//      model.thumbnailImage = image;
//      model.asset = asset;
//      [self.photoArray addObject:model];
//    }];
    for (PHAsset * asset in [XMAssetsManager getAssets]) {
          XMPhotoModel * model = [XMPhotoModel new];
          model.asset = asset;
          [self.photoArray addObject:model];
    }
}

-(void)dealloc {
    NSLog(@"deallocdeallocdeallocdealloc");
}

-(void)countRefresh {
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.selectArray.count,self.pickCount];
}

- (IBAction)okButtonClick:(id)sender {
    if (self.okbuttonClick) {
        NSMutableArray * imageArray = [NSMutableArray array];
        for (XMPhotoModel * model in self.selectArray) {
            [XMAssetsManager getPhotoWithAssets:model.asset imageSize:CGSizeZero option:nil complete:^(UIImage *image, NSDictionary *info) {
                [imageArray addObject:image];
            }];
        }
        self.okbuttonClick(imageArray);
    }
}

@end
