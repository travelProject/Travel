//
//  FYLookMoreCityVC.h
//  banlv
//
//  Created by lifeiyang on 16/5/12.
//  Copyright © 2016年 llz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedIdBlock)(NSString *cityId,NSString *cityName);

@interface FYLookMoreCityVC : UIViewController

@property (nonatomic,copy)SelectedIdBlock selectedIdBlock;

@property(nonatomic,assign)BOOL flag;

@end
