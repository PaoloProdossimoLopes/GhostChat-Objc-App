//
//  SignUpViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "SignUpViewController.h"
#import "HomeTableViewController.h"

@interface SignUpViewController()

//MARK: TextField
@property (strong, nonatomic) IBOutlet UITextField * nameTextField;
@property (strong, nonatomic) IBOutlet UITextField * emailTextField;
@property (strong, nonatomic) IBOutlet UITextField * passwordTextField;

//MARK: Button
@property (strong, nonatomic) IBOutlet UIButton * registerButton;

@end

@implementation SignUpViewController

//MARK: - IBActions

- (IBAction)registerButtonHandleTapped: (id)sender {
    NSLog(@"Register button was tapped");
    
    BOOL isValid = (self.nameTextField.text.length > 0 &&
                    self.emailTextField.text.length > 0 &&
                    self.passwordTextField.text.length);
    
    if (isValid) { [self submitYourInformations]; }
    else { [self showAlert]; }
    
}

//MARK: - Helpers

- (void)submitYourInformations {
    NSDictionary * signUpParameters = [[NSDictionary alloc] init];
    
    signUpParameters = @{@"name": self.nameTextField.text,
                         @"email": self.emailTextField.text,
                         @"password": self.passwordTextField.text};
    
    [self registerNewAccountInFirebase: signUpParameters];
    
    NSLog(@"%@", signUpParameters);
}

- (void)registerNewAccountInFirebase: (NSDictionary*)dict {
    
    [[FIRAuth auth] createUserWithEmail: dict[@"email"]
                               password: dict[@"password"]
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
        
        if (error == nil) { [self saveOnDataBase: authResult.user userInfo: dict]; }
        else { [self showAlert]; }
        
    }];
}

- (void)saveOnDataBase: (FIRUser*)user userInfo: (NSDictionary<NSString*,id>*)userInfo {
    
    FIRDatabaseReference* database = [[FIRDatabase database] reference];
    FIRDatabaseReference* userReference = [[database child: @"user"] child: user.uid];
    
    NSDictionary * userInformation = [[NSDictionary alloc] init];
    userInformation = @{@"uid": user.uid,
                        @"name": self.nameTextField.text,
                        @"email": self.emailTextField.text,
                        @"password": self.passwordTextField.text};
    
    [userReference setValue: userInformation withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (error == nil) {
            [self navigateToHomeView];
        } else {
            [self showAlert];
        }
    }];
    
}

- (void)navigateToHomeView {
        UIViewController* vc = [[HomeTableViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:NULL];
}

- (void)showAlert {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle: @"Ops"
                                 message: @"Plese make sure all fields are filled out"
                                 preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction
                              actionWithTitle: @"OK"
                              style: UIAlertActionStyleDefault
                              handler:nil];
    
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
