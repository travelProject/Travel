//
//  FYCityHouseMapCell.m
//  banlv
//
//  Created by lfy on 16/5/17.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYCityHouseMapCell.h"

typedef enum : NSUInteger {
    SpaceTypeLivingRoom = 1,
    SpaceTypeJointRent = 2,
    SpaceTypeSeparateHouse = 3,
} SpaceType;

@interface FYCityHouseMapCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *introduceLab;
@property (weak, nonatomic) IBOutlet UIImageView *star11;

@property (weak, nonatomic) IBOutlet UIImageView *star22;
@property (weak, nonatomic) IBOutlet UIImageView *star33;
@property (weak, nonatomic) IBOutlet UIImageView *star44;
@property (weak, nonatomic) IBOutlet UIImageView *star55;


@property(nonatomic,strong)NSArray<UIImageView *> *starArr;

@property (weak, nonatomic) IBOutlet UILabel *commentLab;



@end

@implementation FYCityHouseMapCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor whiteColor];
}

- (NSArray<UIImageView *> *)starArr
{
    if (!_starArr) {
        
        self.starArr = [NSArray arrayWithObjects:self.star11, self.star22, self.star33, self.star44, self.star55, nil];
    }
    
    return _starArr;
}

- (void)setCityHouseData:(FYCityHouseListData *)cityHouseData
{
    _cityHouseData = cityHouseData;
    
    //设置左边房间图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_cityHouseData.pictureList[0]] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    //    spaceType;//房间类型（1.客厅沙发 2.合租房间 榻榻米 3.独立房间 双人床）
    switch (_cityHouseData.spaceType.integerValue) {
            
        case SpaceTypeLivingRoom:
            
            self.introduceLab.text = [_cityHouseData.districtName stringByAppendingString:@"·客厅·沙发"];
            
            break;
            
        case SpaceTypeJointRent:
            
            self.introduceLab.text = [_cityHouseData.districtName stringByAppendingString:@"·合租房间·榻榻米"];
            
            break;
            
        case SpaceTypeSeparateHouse:
            
            self.introduceLab.text = [_cityHouseData.districtName stringByAppendingString:@"·独立房间·双人床"];
            
            break;
            
        default:
            
            break;
    }
    
    //价格需要截取到小数点后一位
    //%.1f  表示小数点一位，%.2f 表示小数点2位，依次类推
    self.priceLab.text = [NSString stringWithFormat:@"¥%.1f",_cityHouseData.price.floatValue];
    self.priceLab.textColor = [UIColor colorWithRed:0.38 green:0.94 blue:0.63 alpha:1.0];
    
    self.titleLab.text = [NSString stringWithFormat:@"· %@",_cityHouseData.title];
    
    self.commentLab.text = [NSString stringWithFormat:@"· %@条评价",_cityHouseData.reviewAmount];
    
    //星星评论
    for (NSInteger i = 0; i < _cityHouseData.reviewScore.integerValue; i++) {
        
        self.starArr[i].image = [UIImage imageNamed:@"hongxin"];
        
    }
    
    for (NSInteger j = _cityHouseData.reviewScore.integerValue; j < 5; j++) {
        
        self.starArr[j].image = [UIImage imageNamed:@"shoucang"];
    }
    
}

//- (void)setFrame:(CGRect)frame
//{
//    
//    CGRect newFrame = CGRectMake(20 + frame.origin.x, 0, 414 - 40, 100);
//    
//    [super setFrame:newFrame];
//}

@end
