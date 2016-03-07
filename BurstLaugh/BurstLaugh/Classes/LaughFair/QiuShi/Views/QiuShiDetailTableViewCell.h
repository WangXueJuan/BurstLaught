//
//  QiuShiDetailTableViewCell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QiuShiDetailModell.h"
@interface QiuShiDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) QiuShiDetailModell *detailModell;
+ (CGFloat)getCellHeightDetailModel:(QiuShiDetailModell *)model;

@end
