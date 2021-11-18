//
//  SnapChatAppRouter.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "SnapChatAppRouter.h"

#import "HomeTableViewController.h"

#import "SignInViewModel.h"
#import "SignInViewController.h"

#import "MessageViewController.h"
#import "MessageViewModel.h"

@interface SnapChatAppRouter()

- (instancetype)init NS_UNAVAILABLE;

@end

@implementation SnapChatAppRouter

+ (id) shared {
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (UINavigationController*)routeToHomeNavigationViewController {
    HomeTableViewController * vc = [[HomeTableViewController alloc] init];
    HomeViewModel *viewModel = [[HomeViewModel alloc] init];
    
    vc.viewModel = viewModel;
    
    UINavigationController * nav = [[UINavigationController alloc]
                                    initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    return nav;
}

- (UINavigationController*)routeToSplashView {
    UIStoryboard * sb = [UIStoryboard storyboardWithName: @"Splash" bundle: nil];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier: @"SplashViewController"];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    return nav;
}

- (UIViewController*)routeToSignUpView {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    
    return vc;
}

- (UIViewController*)routeToSignInView {
    UIStoryboard * sb = [UIStoryboard storyboardWithName: @"SignIn" bundle:NULL];
    SignInViewController * vc = [sb instantiateViewControllerWithIdentifier:
                                 @"SignInViewController"];
    
    SignInViewModel *viewModel = [[SignInViewModel alloc]init];
    vc.viewModel = viewModel;
    
    return vc;
}

- (UIViewController*)routeToMessageView:(NSMutableArray*)message key:(NSString*)key {
    MessageViewController *vc = [[MessageViewController alloc] init];
    MessageViewModel *viewModel = [[MessageViewModel alloc] init];
    
    vc.messageArray = message;
    vc.keys = key;
    vc.viewModel = viewModel;
    
    return vc;
}

@end
