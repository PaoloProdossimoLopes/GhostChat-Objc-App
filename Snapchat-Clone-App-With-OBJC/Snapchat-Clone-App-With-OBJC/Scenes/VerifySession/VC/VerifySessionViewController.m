//
//  VerifySessionViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "VerifySessionViewController.h"

@interface VerifySessionViewController()
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView * loaderIndicator;
@end

@implementation VerifySessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkIfUserAreLogged];
}

- (void)checkIfUserAreLogged {
    
    [self.loaderIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self callThirdPart];
    });

}

- (void)callThirdPart {
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
            if (user != nil) { [self routeToHome]; }
            else { [self routeToSplashView]; }
        [self.loaderIndicator stopAnimating];
    }];
}

- (void)routeToHome {
    UIViewController * vc = [[HomeTableViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc]
                                    initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController: nav animated:YES completion:NULL];
}

- (void)routeToSplashView {
    UIStoryboard * sb = [UIStoryboard storyboardWithName: @"Splash" bundle: nil];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier: @"SplashViewController"];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController: nav animated: YES completion: NULL];
    
}

@end
