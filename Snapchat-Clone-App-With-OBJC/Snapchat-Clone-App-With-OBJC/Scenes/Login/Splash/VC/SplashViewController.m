//
//  SplashViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "SplashViewController.h"

//MARK: - Interface

@interface SplashViewController()

@property (strong, nonatomic) IBOutlet UIButton * singUpButton;
@property (strong, nonatomic) IBOutlet UIButton * signinButton;

@property (strong, nonatomic) SnapChatAppRouter *router;

@end

#pragma mark - Implementation

@implementation SplashViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.router = [SnapChatAppRouter shared];
    [self configureButton];
}

#pragma mark - Helpers

- (void)configureButton {
    self.singUpButton.layer.cornerRadius = self.singUpButton.frame.size.height/2;
    self.signinButton.layer.cornerRadius = self.signinButton.frame.size.height/2;
}

#pragma mark - Selectors

- (IBAction)signUpButtonHandleTapped: (id)sender {
    [[self navigationController]
     pushViewController:[self.router routeToSignUpView] animated:YES];
}

- (IBAction)signInButtonHandleTapped: (id)sender {
    [[self navigationController]
     pushViewController: [self.router routeToSignInView] animated:YES];
}

@end
