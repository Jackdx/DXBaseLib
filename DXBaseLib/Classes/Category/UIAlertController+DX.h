//
//  UIAlertController+DX.h
//  DXBaseLib
//
//  Created by 邓翔 on 2020/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^UIAlertControllerCompletionBlock) (UIAlertController * __nonnull controller, UIAlertAction * __nonnull action, NSInteger buttonIndex);

FOUNDATION_EXPORT NSInteger const UIAlertControllerBlocksCancelButtonIndex;
FOUNDATION_EXPORT NSInteger const UIAlertControllerBlocksDestructiveButtonIndex;
FOUNDATION_EXPORT NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex;

@interface UIAlertController (DX)
/*      使用方式
  [UIAlertController dx_showAlertInViewController:self
               withTitle:@"Test Alert"
                 message:@"Test Message"
       cancelButtonTitle:@"Cancel"
  destructiveButtonTitle:nil
       otherButtonTitles:@[@"First Other"]
                                         tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
      if (buttonIndex == UIAlertControllerBlocksFirstOtherButtonIndex) {
          NSLog(@"buttonIndex==%ld,title==%@",buttonIndex,action.title);
      }
      
  }];
*/

/**
      便利的创建方式
*/
+ (nonnull instancetype)dx_showAlertInViewController:(nonnull UIViewController *)viewController
             withTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
     otherButtonTitles:(nullable NSArray *)otherButtonTitles
              tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;

+ (nonnull instancetype)dx_showInViewController:(nonnull UIViewController *)viewController
                         withTitle:(nullable NSString *)title
                           message:(nullable NSString *)message
                    preferredStyle:(UIAlertControllerStyle)preferredStyle
                 cancelButtonTitle:(nullable NSString *)cancelButtonTitle
            destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                 otherButtonTitles:(nullable NSArray *)otherButtonTitles
                          tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock;
@end

NS_ASSUME_NONNULL_END
