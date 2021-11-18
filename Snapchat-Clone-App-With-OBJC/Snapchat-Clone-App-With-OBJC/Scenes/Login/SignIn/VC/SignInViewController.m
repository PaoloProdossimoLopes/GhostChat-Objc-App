//
//  SignInViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "SignInViewController.h"

@interface SignInViewController()

@property (strong, nonatomic) IBOutlet UITextField * emailTextField;
@property (strong, nonatomic) IBOutlet UITextField * passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton * loginButton;

@end

@implementation SignInViewController

- (IBAction)loginButtonHandleTapped {
    
    BOOL isValid = (self.emailTextField.text.length > 0 &&
                    self.passwordTextField.text.length > 0);
    
    if (isValid) { [self checkIfUserAlreadyRegistered]; }
    else { [self showError]; }
    
}

- (void)checkIfUserAlreadyRegistered {
    
    [[FIRAuth auth] signInWithEmail: self.emailTextField.text
                           password: self.passwordTextField.text
                         completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        
        if (error == nil) {
            NSLog(@"DEBUG: Go to Home");
            [self goToHomeView];
        } else {
            NSLog(@"DEBUG: Nao tem cadastro ainda");
            [self showError];
        }
    }];
    
}

- (void)goToHomeView {
    
    UIViewController * vc = [[HomeTableViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:nav animated:YES completion:NULL];
    
    NSLog(@"Loggin sucess!");
}

- (void)showError {
    
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