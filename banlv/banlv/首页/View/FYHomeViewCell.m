//
//  FYHomeViewCell1.m
//  banlv
//
//  Created by lifeiyang on 16/5/11.
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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCityData:(FYHomeViewCityData *)cityData
{
    _cityData = cityData;
    
    [self.cityPic sd_setImageWithURL:[NSURL URLWithString:_cityData.mainPic] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
    
    self.chineseName.text = _cityData.cityNameCh;
    [self fontWithLab:self.chineseName];
    
    self.englishName.text = _cityData.cityNameEn;
    [self fontWithLab:self.englishName];
    
    self.cityId = _cityData.ID;
    
}

- (void)fontWithLab:(UILabel *)label
{
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.f];
}

@end
