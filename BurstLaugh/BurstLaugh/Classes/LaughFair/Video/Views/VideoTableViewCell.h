//
//  VideoTableViewCell.h
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoTableViewCell : UITableViewCell
{
    NSInteger Clickount;  //点击次数
}

@property (nonatomic, strong) UILabel *txtLabel;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIButton *priseBtn;
@property (nonatomic, strong) UIButton *downBtn;
@property (nonatomic, strong) UILabel *durationLabel;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UIImageView *iconIm;
@property (nonatomic, strong) UIView *uiClear; //添加分割线
@property (nonatomic, strong) videoModel *videoModel;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, assign) NSInteger clickCount;
@property (nonatomic, strong) UIButton *quitBtn;
@property (nonatomic, strong) UILabel *inLabel; 

//自定义文本高度
+ (CGFloat)getCellHeightModel:(videoModel *)model;

@end
