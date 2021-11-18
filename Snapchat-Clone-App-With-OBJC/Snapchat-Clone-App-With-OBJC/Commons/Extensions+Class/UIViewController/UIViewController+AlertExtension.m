//
//  UIViewController+AlertExtension.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "UIViewController+AlertExtension.h"

@implementation UIViewController (MYCUSTOMVIEW)
- (void)showCustomAlertDefault {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: @"Oops"
                                 message: @"Plese make sure all fields are filled out"
                                 preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction
                              actionWithTitle: @"OK"
                              style: UIAlertActionStyleDefault
                              handler: NULL];
    
    [alert addAction: action];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
@end
