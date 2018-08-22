//
//  XMPhotoPickerVCViewController.m
//  XMPhotoPicker
//
//  Created by 罗晓明 on 2018/7/24.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "XMPhotoPickerVC.h"
#import "XMPhotoPickerListViewController.h"
@interface XMPhotoPickerVC ()
@property(nonatomic,strong) XMPhotoPickerListViewController * pikerVC;
@end

@implementation XMPhotoPickerVC


-(instancetype)init {
     XMPhotoPickerListViewController * vc = [[XMPhotoPickerListViewController alloc] initWithNibName:@"XMPhotoPickerListViewController" bundle:[NSBundle bundleForClass:[self class]]];
    if(self = [super initWithRootViewController:vc]) {
        XMPhotoPickerListViewController * pickVC =  (XMPhotoPickerListViewController *)self.childViewControllers.firstObject;
        __weak typeof(self)weakSelef = self;
        [pickVC setOkbuttonClick:^(NSArray<UIImage *> *imageArray) {
            if (weakSelef.okbuttonClick) {
                weakSelef.okbuttonClick(imageArray);
            }
            [weakSelef dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return self;
}

-(void)setPickCount:(NSInteger)pickCount {
    ((XMPhotoPickerListViewController *)self.childViewControllers.firstObject).pickCount = pickCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
