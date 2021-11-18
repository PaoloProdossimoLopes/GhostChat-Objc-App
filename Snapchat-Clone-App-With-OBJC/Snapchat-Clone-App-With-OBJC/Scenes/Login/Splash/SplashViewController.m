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


//MARK: - Implementation

@implementation SplashViewController

- (IBAction)signUpButtonHandleTapped: (id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SignUp" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
    
    NSLog(@"DEBUG: SingUpButton was Tappped");
}

- (IBAction)signInButtonHandleTapped: (id)sender {
    
    UIStoryboard * sb = [UIStoryboard storyboardWithName: @"SignIn" bundle:NULL];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier: @"SignInViewController"];
    [[self navigationController] pushViewController:vc animated:YES];
    
    NSLog(@"DEBUG: SingIpButton was Tappped");
}

@end
