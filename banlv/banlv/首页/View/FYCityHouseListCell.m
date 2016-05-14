//
//  FYCityHouseListCell.m
//  banlv
//
//  Created by lifeiyang on 16/5/14.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseListCell.h"

//轮播图
#import "FYCarouselPic.h"

@interface FYCityHouseListCell ()

@property (weak, nonatomic) IBOutlet FYCarouselPic *carouselView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *xinImageView;

@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyRateLabel;

@property(nonatomic,assign) CGFloat houseCellHeight;

@end

@implementation FYCityHouseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userPic.layer.cornerRadius = 20.f;
    self.userPic.layer.masksToBounds = YES;
    
    self.bottomView.backgroundColor = [UIColor colorWithRed:0.97 green:0.96 blue:0.96 alpha:1.0];
    
    
    
}
- (IBAction)xinCollection:(id)sender {
}

- (void)setCityHouseData:(FYCityHouseListData *)cityHouseData
{
    _cityHouseData = cityHouseData;
    
    //轮播图数据
    self.carouselView.picArr = _cityHouseData.pictureList;
    
    self.introduceLabel.text = _cityHouseData.districtName;
    self.priceLabel.text = _cityHouseData.price;
    self.titleLabel.text = _cityHouseData.title;
    [self.userPic sd_setImageWithURL:[NSURL URLWithString:_cityHouseData.ownerPic] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.userName.text = _cityHouseData.ownerName;
    
    self.reviewLabel.text = [NSString stringWithFormat:@"%@条评价",_cityHouseData.reviewAmount];
    
    NSString *replyStr = [NSString stringWithFormat:@"回复率%@",_cityHouseData.replyRate];
    
    self.replyRateLabel.text = [replyStr stringByAppendingString:@"%"];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
