//
//  QiuShiDetailViewController.h
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qiushiModel.h"
#import "QiuShiTableViewCell.h"

@interface QiuShiDetailViewController : UIViewController
@property (nonatomic, strong) qiushiModel *QiushiModel;
@property (nonatomic, copy)  NSString  *_detailId;

@end
