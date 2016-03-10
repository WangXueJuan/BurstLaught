//
//  QiuShiTableViewCell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qiushiModel.h"
#import "jokerModel.h"

@protocol collectDelegate <NSObject>

- (void)collectionClick:(UIButton *)btn;

//- (void)sharedClick:(UIButton *)btn;

@end

@interface QiuShiTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImage; //头像
@property (nonatomic, strong) UILabel *nameLabel; //名字
@property (nonatomic, strong) UILabel *contextLabel; //文字
@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UIButton *countBtn; //评论此时
@property (nonatomic, strong) UIButton *sharBtn;  //分享次数
@property (nonatomic, strong) qiushiModel *qiushiModel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) jokerModel *jokerModel;

@property (nonatomic, assign) id<collectDelegate>delegate;
//自定义一个方法，计算cell的高度
//幽默糗事界面的计算方法
+ (CGFloat)getCellHeightModel:(qiushiModel *)model;
//段子界面的计算方法
+ (CGFloat)getCellHeightJokerModel:(jokerModel *)model;



@end
