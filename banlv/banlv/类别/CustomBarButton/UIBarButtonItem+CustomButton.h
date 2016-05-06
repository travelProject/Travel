//
//  UIBarButtonItem+CustomButton.h
//  百思
//
//  Created by lcy on 16/3/22.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
//就是用来设置navigationItem的样式
//通过静态方法自定义个barButtonItem对象
@interface UIBarButtonItem (CustomButton)


+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName
                               highlitImageName:(NSString *)highlitImageName
                                     withAction:(SEL)action
                                         target:(id)target
                                      itemTitle:(NSString *)itemTitle
                                         offset:(UIControlContentHorizontalAlignment)alignment;

//全局重置barbutton的titleColor
- (void)setBarButtonItemColor:(UIColor *)color;

@end
