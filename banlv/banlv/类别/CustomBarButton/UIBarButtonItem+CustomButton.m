//
//  UIBarButtonItem+CustomButton.m
//  百思
//
//  Created by lcy on 16/3/22.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIBarButtonItem+CustomButton.h"
//就是用来设置navigationItem的样式
//通过静态方法自定义个barButtonItem对象
@implementation UIBarButtonItem (CustomButton)

/**
 *
 *
 *  @param imageName        背景图
 *  @param highlitImageName 点击高亮图
 *  @param action           点击后执行的方法
 *  @param target           <#target description#>
 *  @param itemTitle        <#itemTitle description#>
 *  @param alignment        <#alignment description#>
 *
 *  @return
 */
+ (UIBarButtonItem *)barButtonItemWithImageName:(NSString *)imageName highlitImageName:(NSString *)highlitImageName withAction:(SEL)action target:(id)target itemTitle:(NSString *)itemTitle offset:(UIControlContentHorizontalAlignment)alignment{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (highlitImageName) {
        [btn setImage:[UIImage imageNamed:highlitImageName] forState:UIControlStateHighlighted];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (itemTitle) {
        
        [btn setTitle:itemTitle forState:UIControlStateNormal];
    }
    
    btn.frame = CGRectMake(0, 0, 60, 44);
    
    btn.contentHorizontalAlignment = alignment;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [item setBarButtonItemColor:[UIColor blackColor]];
    
    return item;
}

//全局重置barbutton的titleColor
- (void)setBarButtonItemColor:(UIColor *)color{
    
    UIButton *btn = (UIButton *)self.customView;
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    
    /*
     NSDictionary *attributes = @{NSForegroundColorAttributeName:color};
     
     [self setTitleTextAttributes:attributes forState:UIControlStateNormal];
     */
}

@end
