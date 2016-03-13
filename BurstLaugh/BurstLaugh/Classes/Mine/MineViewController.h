//
//  MineViewController.h
//  BurstLaughing
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiuShiTableViewCell.h"
#import "qiushiModel.h"
@interface MineViewController : UIViewController
//接收幽默糗事界面的数据
@property (nonatomic, strong) qiushiModel *mineModel;
@property (nonatomic, copy) NSString *iconImage;

@end
