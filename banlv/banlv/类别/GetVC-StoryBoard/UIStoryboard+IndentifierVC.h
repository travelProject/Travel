//
//  UIStoryboard+IndentifierVC.h
//  百思
//
//  Created by lcy on 16/3/27.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (IndentifierVC)

+ (UIViewController *)viewControllerWithStoryBoardName:(NSString *)stroryBoardName
                                         indentifierVC:(NSString *)identifier;

@end
