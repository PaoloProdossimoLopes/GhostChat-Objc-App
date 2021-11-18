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

@end

#pragma mark - Implementation

@implementation SplashViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureButton];
}

#pragma mark - Helpers

- (void)configureButton {
    self.singUpButton.layer.cornerRadius = self.singUpButton.frame.size.height/2;
    self.signinButton.layer.cornerRadius = self.signinButton.frame.size.height/2;
}

#pragma mark - Selectors

- (IBAction)signUpButtonHandleTapped: (id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (IBAction)signInButtonHandleTapped: (id)sender {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName: @"SignIn" bundle:NULL];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier: @"SignInViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
