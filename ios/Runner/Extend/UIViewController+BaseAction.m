//
//  UIViewController+BaseAction.m
//
//

#import "UIViewController+BaseAction.h"

@implementation UIViewController (BaseAction)




/// 获取栈中最后一个vc
+ (UIViewController *)currentViewController{
    UIViewController * rootVC = [UIApplication sharedApplication].delegate.window.rootViewController ;
    return [self currentViewControllerFrom:rootVC];
}


+ (UIViewController *)currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        UIViewController *v = [nav.viewControllers lastObject];
        return [self currentViewControllerFrom:v];
    }else if([viewController isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabVC = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:[tabVC.viewControllers objectAtIndex:tabVC.selectedIndex]];
    }else if(viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}


@end







