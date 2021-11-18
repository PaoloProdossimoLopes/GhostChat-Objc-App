//
//  SignInViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "SignInViewController.h"

@interface SignInViewController()

@property (strong, nonatomic) SnapChatAppRouter *router;

@property (strong, nonatomic) IBOutlet UITextField * emailTextField;
@property (strong, nonatomic) IBOutlet UITextField * passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton * loginButton;

@end

@implementation SignInViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.router = [[SnapChatAppRouter alloc] init];
    [self configureUI];
}

#pragma mark - Helpers

- (void)configureUI {
    self.loginButton.layer.cornerRadius = self.loginButton.frame.size.height/2;
    self.navigationController.navigationBar.tintColor = UIColor.orangeColor;
}

#pragma mark - Selectors

- (IBAction)loginButtonHandleTapped {
    [self checkIfUserAlreadyRegistered];
}

- (void)checkIfUserAlreadyRegistered {
    [self.viewModel
     checkIfUserAlreadyRegistered:self.emailTextField.text
     password: self.passwordTextField.text successCompletion:^{
        [self goToHomeView];
        
    } failureCompletion:^(NSError * _Nonnull error) {
        [self showCustomAlertDefault];
    }];
    
}

- (void)goToHomeView {
    [self presentViewController: [[SnapChatAppRouter shared] routeToHomeNavigationViewController] animated:YES completion:NULL];
}

@end


