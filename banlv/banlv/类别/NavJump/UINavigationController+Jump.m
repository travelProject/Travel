//
//  UINavigationController+Jump.m
//  project1
//
//  Created by lcy on 16/4/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UINavigationController+Jump.h"
#import "UIStoryboard+IndentifierVC.h"
@implementation UINavigationController (Jump)

- (void)jumpViewControllerWithStoryBoardName:(NSString *)storyboardName
                            WithVCIdentifier:(NSString *)indentifier
{
    UIViewController *vc = [UIStoryboard viewControllerWithStoryBoardName:storyboardName indentifierVC:indentifier];
    
    [self pushViewController:vc animated:YES];
    
   
    
    
}

@end
