//
//  UIAlertController+DX.m
//  DXBaseLib
//
//  Created by 邓翔 on 2020/3/31.
//

#import "UIAlertController+DX.h"

NSInteger const UIAlertControllerBlocksCancelButtonIndex = 0;
NSInteger const UIAlertControllerBlocksDestructiveButtonIndex = 1;
NSInteger const UIAlertControllerBlocksFirstOtherButtonIndex = 2;

@implementation UIAlertController (DX)

+ (nonnull instancetype)dx_showAlertInViewController:(nonnull UIViewController *)viewController
             withTitle:(nullable NSString *)title
               message:(nullable NSString *)message
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
     otherButtonTitles:(nullable NSArray *)otherButtonTitles
              tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock
{
    return [self dx_showInViewController:viewController
                             withTitle:title
                               message:message
                        preferredStyle:UIAlertControllerStyleAlert
                     cancelButtonTitle:cancelButtonTitle
                destructiveButtonTitle:destructiveButtonTitle
                     otherButtonTitles:otherButtonTitles
                              tapBlock:tapBlock];
}

+ (nonnull instancetype)dx_showInViewController:(nonnull UIViewController *)viewController
             withTitle:(nullable NSString *)title
               message:(nullable NSString *)message
        preferredStyle:(UIAlertControllerStyle)preferredStyle
     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
     otherButtonTitles:(nullable NSArray *)otherButtonTitles
              tapBlock:(nullable UIAlertControllerCompletionBlock)tapBlock
{
    UIAlertController *strongController = [self alertControllerWithTitle:title
                                                                 message:message
                                                          preferredStyle:preferredStyle];
    
    __weak UIAlertController *controller = strongController;
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action){
                                                                 if (tapBlock) {
                                                                     tapBlock(controller, action, UIAlertControllerBlocksCancelButtonIndex);
                                                                 }
                                                             }];
        [controller addAction:cancelAction];
    }
    
    if (destructiveButtonTitle) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                                    style:UIAlertActionStyleDestructive
                                                                  handler:^(UIAlertAction *action){
                                                                      if (tapBlock) {
                                                                          tapBlock(controller, action, UIAlertControllerBlocksDestructiveButtonIndex);
                                                                      }
                                                                  }];
        [controller addAction:destructiveAction];
    }
    
    for (NSUInteger i = 0; i < otherButtonTitles.count; i++) {@autoreleasepool{
        NSString *otherButtonTitle = otherButtonTitles[i];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action){
                                                                if (tapBlock) {
                                                                    tapBlock(controller, action, UIAlertControllerBlocksFirstOtherButtonIndex + i);
                                                                }
                                                            }];
        [controller addAction:otherAction];
    }}
    
    
    [viewController presentViewController:controller animated:YES completion:nil];
    
    return controller;
}

@end
