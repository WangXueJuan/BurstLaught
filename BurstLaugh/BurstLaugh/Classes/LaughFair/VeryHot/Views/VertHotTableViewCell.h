//
//  VertHotTableViewCell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "verHotModel.h"
@interface VertHotTableViewCell : UITableViewCell
@property (nonatomic, strong) verHotModel *verModel;
//定义一个计算cell高度的类方法，可在外调用
+ (CGFloat)getCellHeightMode:(verHotModel *)hotModel;


@end
