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

typedef enum : NSUInteger {
    SpaceTypeLivingRoom = 1,
    SpaceTypeJointRent = 2,
    SpaceTypeSeparateHouse = 3,
} SpaceType;

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
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)xinCollection:(id)sender {
    
    self.xinImageView.selected = !self.xinImageView.isSelected;
    
    
    
}

- (void)setCityHouseData:(FYCityHouseListData *)cityHouseData
{
    _cityHouseData = cityHouseData;
    
    //轮播图数据
    self.carouselView.picArr = _cityHouseData.pictureList;
    
//    spaceType;//房间类型（1.客厅沙发 2.合租房间 榻榻米 3.独立房间 双人床）
    switch (_cityHouseData.spaceType.integerValue) {
            
        case SpaceTypeLivingRoom:
            
            self.introduceLabel.text = [_cityHouseData.districtName stringByAppendingString:@"·客厅·沙发"];
            
            break;
            
        case SpaceTypeJointRent:
            
            self.introduceLabel.text = [_cityHouseData.districtName stringByAppendingString:@"·合租房间·榻榻米"];
            
            break;
            
        case SpaceTypeSeparateHouse:
            
            self.introduceLabel.text = [_cityHouseData.districtName stringByAppendingString:@"·独立房间·双人床"];
            
            break;
            
        default:
            
            break;
    }
    
    //价格需要截取到小数点后一位
    //%.1f  表示小数点一位，%.2f 表示小数点2位，依次类推
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.1f",_cityHouseData.price.floatValue];
    self.priceLabel.textColor = [UIColor colorWithRed:0.40 green:0.74 blue:0.75 alpha:1.0];
    
    self.titleLabel.text = [NSString stringWithFormat:@"· %@",_cityHouseData.title];
    
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
