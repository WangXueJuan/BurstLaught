//
//  VertHotTableViewCell.m
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "VertHotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HWTools.h"

@interface VertHotTableViewCell ()
{
    CGPoint point1;
}
@property(nonatomic, retain) UIImageView *imageIcon;
@property(nonatomic, retain) UIImageView *imagePctiu;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *txtLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *inputLabel;

@end

@implementation VertHotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configView];
        
    }
    return self;
}

- (void)configView{
    //创建相关控件
    //图标
    self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5,kWidth / 6, kWidth / 6)];
    self.imageIcon.layer.cornerRadius = kWidth / 6 / 2.0;
    self.imageIcon.clipsToBounds = YES;
    [self.contentView addSubview:self.imageIcon];
    //name
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 6 + 20, 5, kWidth / 2 - 50, 30)];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [self.contentView addSubview:self.nameLabel];
    //time
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 1.60, 5, kWidth - kWidth / 1.8, 30)];
    self.timeLabel.font = [UIFont systemFontOfSize:11.0];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    //text
    self.txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 6 + 20, 35, kWidth * 0.65, 60)];
    self.txtLabel.numberOfLines = 0;
    [self.contentView addSubview:self.txtLabel];
    //picture
    self.imagePctiu = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth / 5, 80,kWidth - (kWidth / 3), kWidth / 2.5)];
    self.imagePctiu.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imagePctiu];
    //输入label
    self.inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth / 5, kWidth / 2.5 - 30, kWidth - (kWidth / 3), 30)];
    self.inputLabel.backgroundColor = [UIColor blackColor];
    self.inputLabel.text = @" 笑神经,最新爆笑热料，让你笑不停!";
    self.inputLabel.textAlignment = NSTextAlignmentRight;
    self.inputLabel.textColor = [UIColor whiteColor];
    self.inputLabel.font = [UIFont systemFontOfSize:20.0];
    
    
}

//重写model的set方法
- (void)setVerModel:(verHotModel *)verModel {
    //获取图片
    [self.imagePctiu sd_setImageWithURL:[NSURL URLWithString:verModel.textImage] placeholderImage:nil];
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:verModel.icon] placeholderImage:nil];
    //重新给cellLabel赋值
    CGFloat height = [HWTools getTextHeightWithText:verModel.text];
    CGRect frame = self.txtLabel.frame;
    frame.size.height = height;
    self.txtLabel.frame = frame;
    self.txtLabel.text = [NSString stringWithFormat:@"%@",verModel.text];
     self.txtLabel.numberOfLines = 0;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",verModel.name];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",verModel.passtime];
    //重新给图片的frame赋值
    self.imagePctiu.frame = CGRectMake(10, frame.size.height + (kWidth / 6) - 10, kWidth - 20, verModel.height / 3);
    //输入label
    self.inputLabel.frame = CGRectMake(0, verModel.height / 3 - 40, kWidth - 20, 40);
    if (verModel.textImage != nil) {
        [self.imagePctiu addSubview:self.inputLabel];

    } else {
        [self.inputLabel removeFromSuperview];
    
    }


}




- (void)handleGesture1:(UITapGestureRecognizer *)gesture{

}

#pragma mark ------------------ 自定义高度

+ (CGFloat)getCellHeightMode:(verHotModel *)hotModel {
    CGFloat textHeight = [HWTools getTextHeightWithText:hotModel.text];
    if (hotModel.textImage == nil) {
        return textHeight + 40;
    } else
        
        return textHeight + hotModel.height / 3 + 60;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
