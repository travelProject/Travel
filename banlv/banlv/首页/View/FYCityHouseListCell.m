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

@property (weak, nonatomic) IBOutlet UIImageView *userIdentification;
@property (weak, nonatomic) IBOutlet UIImageView *zmAuthon;

@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

@property(nonatomic,strong)NSArray<UIImageView *> *starArr;

@end

@implementation FYCityHouseListCell

//星星数组
- (NSArray *)starArr
{
    if (!_starArr) {
        
        _starArr = [NSArray arrayWithObjects:self.star1, self.star2, self.star3, self.star4, self.star5, nil];
    }
    
    return _starArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userPic.layer.cornerRadius = 20.f;
    self.userPic.layer.masksToBounds = YES;
    
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)xinCollection:(id)sender {
    
    self.xinImageView.selected = !self.xinImageView.isSelected;
    
    BmobObject *gameScore = nil;
    
    if (self.xinImageView.isSelected) {
        
        gameScore = [BmobObject objectWithClassName:@"CollectionHouse"];

        NSMutableDictionary *dic = self.cityHouseData.mj_keyValues;
        
        [dic setValue:self.cityHouseData.userIdentificationStatus forKey:@"userIdentiStatus"];
        
        [dic setValue:@"1" forKey:@"collectionStatus"];

        [dic removeObjectForKey:@"userIdentificationStatus"];//键值对一起删除
        
        [gameScore saveAllWithDictionary:dic];
        
        [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            //进行操作
            if (isSuccessful) {
                
                NSLog(@"上传成功");
            }
            
            if (error) {
                
                NSLog(@"上传失败:%@",error);
            }
            
        }];

    }else if (!self.xinImageView.isSelected)
    {
        
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CollectionHouse"];
        
        [bquery whereKey:@"spaceId" equalTo:self.cityHouseData.spaceId];
        
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            
            
            if (error)
            {
                //进行错误处理
            }else if (array)
            {
                //异步删除object
                [array[0] deleteInBackground];
            }
            
                
            }];
        

    

    }
    
    
    
}

- (void)setCityHouseData:(FYCityHouseListData *)cityHouseData
{
    _cityHouseData = cityHouseData;
    
    //轮播图数据
    self.carouselView.picArr = _cityHouseData.pictureList;
    
    if ([self.cityHouseData.collectionStatus isEqualToString:@"0"]) {
        
        [self.xinImageView setBackgroundImage:[UIImage imageNamed:@"xin_white"] forState:UIControlStateNormal];
    }else if ([self.cityHouseData.collectionStatus isEqualToString:@"1"])
    {
        self.xinImageView.selected = YES;
        [self.xinImageView setBackgroundImage:[UIImage imageNamed:@"hongxin"] forState:UIControlStateNormal];
    }
    
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
    self.priceLabel.textColor = [UIColor colorWithRed:0.38 green:0.94 blue:0.63 alpha:1.0];
    
    self.titleLabel.text = [NSString stringWithFormat:@"· %@",_cityHouseData.title];
    
    [self.userPic sd_setImageWithURL:[NSURL URLWithString:_cityHouseData.ownerPic] placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.userName.text = _cityHouseData.ownerName;
    
    self.reviewLabel.text = [NSString stringWithFormat:@"%@条评价",_cityHouseData.reviewAmount];
    
    NSString *replyStr = [NSString stringWithFormat:@"回复率%@",_cityHouseData.replyRate];
    
    self.replyRateLabel.text = [replyStr stringByAppendingString:@"%"];
    
    //添加实名认证、芝麻信用
    if ([_cityHouseData.userIdentificationStatus isEqualToString:@"2"]) {
        
        
        self.userIdentification.image = [UIImage imageNamed:@"shenfenzheng"];
        
        
        if ([_cityHouseData.zmAuthentication isEqualToString:@"1"]) {
            
            self.zmAuthon.image = [UIImage imageNamed:@"tupian"];
            
        }
        
        
    }else if ([_cityHouseData.zmAuthentication isEqualToString:@"1"])
    {
        self.userIdentification.image = [UIImage imageNamed:@"shenfenzheng"];
        
    }
    
    //星星评论
    for (NSInteger i = 0; i < _cityHouseData.reviewScore.integerValue; i++) {
        
        self.starArr[i].image = [UIImage imageNamed:@"hongxin"];
        
    }
    
    for (NSInteger j = _cityHouseData.reviewScore.integerValue; j < 5; j++) {
        
        self.starArr[j].image = [UIImage imageNamed:@"shoucang"];
    }
    
//    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"CollectionHouse"];
//    
//    [bquery whereKey:@"spaceId" equalTo:self.cityHouseData.spaceId];
//    
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        
//        
//        if (error)
//        {
//            //进行错误处理
//        }else if (array)
//        {
//            //异步删除object
//            BmobObject *collecObj = array[0];
//            
//            NSString *status = [collecObj objectForKey:@"collectionSattus"];
//            
//            NSLog(@"sfhlahl");
//            
//            if ([[collecObj objectForKey:@"collectionSattus"] isEqualToString:@"1"]) {
//                
//                NSLog(@"收藏状态:%@",[collecObj objectForKey:@"collectionSattus"]);
//                
//                self.xinImageView.selected = YES;
//                
//                [self.xinImageView setBackgroundImage:[UIImage imageNamed:@"hongxin"] forState:UIControlStateSelected];
//                
//            }
//            
//        }
//        
//        
//    }];

    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
