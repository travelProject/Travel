//
//  UINavigationController+Jump.h
//  project1
//
//  Created by lcy on 16/4/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
//此类用于Navigation的跳转
@interface UINavigationController (Jump)

- (void)jumpViewControllerWithStoryBoardName:(NSString *)storyboardName WithVCIdentifier:(NSString *)indentifier;

@end
