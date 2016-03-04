//
//  verHotDetailTableViewController.m
//  BurstLaugh
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 王雪娟. All rights reserved.
//

#import "verHotDetailTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface verHotDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UIButton *sharBtn;
@property (weak, nonatomic) IBOutlet UIButton *comentBtn;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation verHotDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.verModel.name;
    //更新时间
    self.timeLabel.text = [NSString stringWithFormat:@"%@",self.verModel.passtime];
    //头像
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:self.verModel.icon] placeholderImage:nil];
    //用户名
    self.nameLabel.text = [NSString stringWithFormat:@"%@",self.verModel.name];
    //text
    self.textLabel.text = [NSString stringWithFormat:@"%@",self.verModel.text];
    //picturer
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:self.verModel.textImage] placeholderImage:nil];
    //赞
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%@",self.verModel.up] forState:UIControlStateNormal];
    //踩
    [self.downBtn setTitle:[NSString stringWithFormat:@"%@",self.verModel.down] forState:UIControlStateNormal];
    //评论
    [self.comentBtn setTitle:[NSString stringWithFormat:@"%@",self.verModel.comment] forState:UIControlStateNormal];
    //分享
    [self.sharBtn setTitle:[NSString stringWithFormat:@"%@",self.verModel.share_url] forState:UIControlStateNormal];
    
    //添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //点击次数
    tap.numberOfTapsRequired = 1;
    //手指个数
    tap.numberOfTouchesRequired = 1;
    //将手势添加到视图
    [self.pictureImage addGestureRecognizer:tap];
    
    
    

}

//评论
- (IBAction)comentBtnAction:(id)sender {
}

//分享
- (IBAction)sharBtnAction:(id)sender {
}

//踩
- (IBAction)downBtnAction:(id)sender {
}

//赞
- (IBAction)priseBtnAction:(id)sender {
}

#pragma mark ---------------------- 懒加载



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
