//
//  UIStoryboard+IndentifierVC.m
//  百思
//
//  Created by lcy on 16/3/27.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIStoryboard+IndentifierVC.h"

@implementation UIStoryboard (IndentifierVC)

+ (UIViewController *)viewControllerWithStoryBoardName:(NSString *)stroryBoardName
                                         indentifierVC:(NSString *)identifier
{
    UIStoryboard *mainStoryBoard = [self storyboardWithName:stroryBoardName bundle:nil];
    
    UIViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:identifier];
    
    return vc;
}
@end
