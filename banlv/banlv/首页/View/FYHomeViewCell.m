//
//  FYHomeViewCell.m
//  banlv
//
//  Created by lfy on 16/5/11.
//  Copyright © 2016年 llz. All rights reserved.
//

#import "FYHomeViewCell.h"

@interface FYHomeViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cityPic;

@property (weak, nonatomic) IBOutlet UILabel *chineseName;
@property (weak, nonatomic) IBOutlet UILabel *englishName;

@property (nonatomic,copy)NSString *cityId;


@end

@implementation FYHomeViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cityData = [[FYHomeViewCityData alloc] init];
}

- (void)setCityData:(FYHomeViewCityData *)cityData
{
    _cityData = cityData;
    
    [self.cityPic sd_setImageWithURL:[NSURL URLWithString:_cityData.mainPic] placeholderImage:nil options:SDWebImageProgressiveDownload];
    
    self.chineseName.text = _cityData.cityNameCh;
    
    self.englishName.text = _cityData.cityNameEn;
    
    self.cityId = _cityData.ID;
    
}

@end
