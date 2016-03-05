//
//  VideoTableViewCell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoModel.h"
@interface VideoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIButton *priseBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UIImageView *iconIm;

@property (nonatomic, strong) videoModel *videoModel;
@property (nonatomic, strong) UIButton *playBtn;

//自定义文本高度
+ (CGFloat)getCellHeightModel:(videoModel *)model;

@end
