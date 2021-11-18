//
//  SignUpViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "SignUpViewController.h"

@interface SignUpViewController()

@property (strong, nonatomic) SnapChatAppRouter *router;

//MARK: TextField
@property (strong, nonatomic) IBOutlet UITextField * nameTextField;
@property (strong, nonatomic) IBOutlet UITextField * emailTextField;
@property (strong, nonatomic) IBOutlet UITextField * passwordTextField;

//MARK: Button
@property (strong, nonatomic) IBOutlet UIButton * registerButton;

@end

@implementation SignUpViewController

# pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

# pragma mark - Helpers

- (void)configureUI {
    self.registerButton.layer.cornerRadius = self.registerButton.frame.size.height/2;
    self.navigationController.navigationBar.tintColor = UIColor.orangeColor;
}

# pragma mark - IBActions

- (IBAction)registerButtonHandleTapped: (id)sender {
    NSLog(@"Register button was tapped");
    
    BOOL isValid = (self.nameTextField.text.length > 0 &&
                    self.emailTextField.text.length > 0 &&
                    self.passwordTextField.text.length);
    
    if (isValid) { [self submitYourInformations]; }
    else { [self showCustomAlertDefault]; }
    
}

# pragma mark - Helpers

- (void)navigateToHomeView {
        [self presentViewController:[[SnapChatAppRouter shared] routeToHomeNavigationViewController] animated:YES completion:NULL];
}

# pragma mark - API

- (void)submitYourInformations {
    NSDictionary * signUpParameters = [[NSDictionary alloc] init];
    
    signUpParameters = @{@"name": self.nameTextField.text,
                         @"email": self.emailTextField.text,
                         @"password": self.passwordTextField.text};
    
    [self registerNewAccountInFirebase: signUpParameters];
    
    NSLog(@"%@", signUpParameters);
}

- (void)registerNewAccountInFirebase: (NSDictionary*)dict {
    
    [self.viewModel
     registerNewAccountInFirebase: dict
     successCompletion:^(FIRAuthDataResult * _Nonnull authResult) {
        [self saveOnDataBase: authResult.user userInfo: dict];
    } failureCompletion:^(NSError * _Nonnull error) {
        [self showCustomAlertDefault];
    }];
    
}

- (void)saveOnDataBase: (FIRUser*)user userInfo: (NSDictionary<NSString*,id>*)userInfo {
    
    NSDictionary * userInformation = [[NSDictionary alloc] init];
    userInformation = @{@"uid": user.uid,
                        @"name": self.nameTextField.text,
                        @"email": self.emailTextField.text,
                        @"password": self.passwordTextField.text};
    
    [self.viewModel saveOnDataBase:user userInformation: userInformation
     successCompletion:^{
        [self navigateToHomeView];
    } failureCompletion:^(NSError * _Nonnull error) {
        [self showCustomAlertDefault];
    }];
    
}

@end
