//
//  SignInViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>

#import "SignInViewModel.h"

#import "HomeTableViewController.h"
#import "UIViewController+AlertExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewController : UIViewController
@property (strong, nonatomic) SignInViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
