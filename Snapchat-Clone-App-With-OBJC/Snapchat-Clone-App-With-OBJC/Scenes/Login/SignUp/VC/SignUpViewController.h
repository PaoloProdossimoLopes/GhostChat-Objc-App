//
//  SignUpViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SignUpViewModel.h"
#import "HomeTableViewController.h"
#import "UIViewController+AlertExtension.h"
#import "SnapChatAppRouter.h"
#import "SignUpViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewController : UIViewController
@property (strong, nonatomic) SignUpViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
