//
//  VideoTableViewCell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/5.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VideoTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation VideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self config];
        }
    return self;
}


- (void)config{
    //内容
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, kWidth - 10, 30)];
    [self.contentView addSubview:tLabel];
    self.txtLabel = tLabel;
    //图片
    UIImageView *PictureImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 35, kWidth - 10, 200)];
    [self.contentView addSubview:PictureImage];
    self.image = PictureImage;
    self.image.userInteractionEnabled = YES;
    //点赞按钮
    UIButton *prBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    prBtn.frame = CGRectMake(2, 237, kWidth / 4, 30);
    [prBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:prBtn];
    self.priseBtn = prBtn;
    //踩按钮
    UIButton *dwBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dwBtn.frame = CGRectMake(kWidth / 4 + 5, 237, kWidth / 4, 30);
    [dwBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:dwBtn];
    self.downBtn = dwBtn;
    //播放次数label
    UILabel *pcLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 2 + 5, 237, kWidth / 4, 30)];
    pcLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:pcLabel];
    self.playCountLabel = pcLabel;
    //时长label
    UILabel *duabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth * 0.75 + 5, 237, kWidth / 4, 30)];
    duabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:duabel];
    self.durationLabel = duabel;
   
    self.backgroundColor = [UIColor whiteColor];
}

//set方法赋值
-(void)setVideoModel:(videoModel *)videoModel {
    //重新给textlabel赋值
    CGFloat height = [[self class] getTextHeightWithText:videoModel.text];
    CGRect frame = self.txtLabel.frame;
    frame.size.height = height;
    self.txtLabel.frame = frame;
    self.txtLabel.numberOfLines = 0;
    //内容
    self.txtLabel.text = [NSString stringWithFormat:@"%@",videoModel.text];
    //图片
    [self.image sd_setImageWithURL:[NSURL URLWithString:videoModel.picture] placeholderImage:nil];
    //重新给其他控件赋frame值
    self.image.frame = CGRectMake(5, frame.size.height + 10, kWidth - 10, 200);
    self.priseBtn.frame = CGRectMake(2, frame.size.height + 220, kWidth / 4, 30);
    self.downBtn.frame = CGRectMake(kWidth / 4 + 5, frame.size.height + 220, kWidth / 4, 30);
    self.playCountLabel.frame = CGRectMake(kWidth / 2 + 5, frame.size.height + 220, kWidth / 4, 30);
    self.durationLabel.frame = CGRectMake(kWidth * 0.75 + 5, frame.size.height + 220, kWidth / 4, 30);
    
    [self.priseBtn setTitle:[NSString stringWithFormat:@"赞 %@",videoModel.up] forState:UIControlStateNormal];
    [self.downBtn setTitle:[NSString stringWithFormat:@"踩 %@",videoModel.down] forState:UIControlStateNormal];
    self.durationLabel.text = [NSString stringWithFormat:@"%.f",videoModel.duration];
    self.playCountLabel.text = [NSString stringWithFormat:@"次数 %@",videoModel.playcount];
    
    
}



//定义一个获取text高度的方法，可在外调用
+ (CGFloat)getTextHeightWithText:(NSString *)txtlabel {
    CGRect txtRect = [txtlabel boundingRectWithSize:CGSizeMake(kWidth - 10, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}  context:nil];
    return txtRect.size.height;
}

+ (CGFloat)getCellHeightModel:(videoModel *)model {
    CGFloat textHeight = [[self class] getTextHeightWithText:model.text];
    if (model.picture == nil) {
         return textHeight + 20;
    }
    return textHeight + 230;
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end