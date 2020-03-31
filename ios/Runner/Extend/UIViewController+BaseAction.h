//
//  UIViewController+BaseAction.h
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaseAction)
//获取栈中最后一个vc
+ (UIViewController *)currentViewController;
+ (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController;



@end
