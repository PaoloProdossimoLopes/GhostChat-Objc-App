//
//  VerifySessionViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 16/11/21.
//

#import "VerifySessionViewController.h"
#import "SnapChatAppRouter.h"

@interface VerifySessionViewController()
    @property (strong, nonatomic) IBOutlet UIActivityIndicatorView * loaderIndicator;
    @property (strong, nonatomic) VerifySessionViewModel *viewModel;
    @property (strong, nonatomic) SnapChatAppRouter *router ;
@end

@implementation VerifySessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[VerifySessionViewModel alloc]init];
    self.router = [SnapChatAppRouter shared];
    
    [self checkIfUserAreLogged];
}

- (void)checkIfUserAreLogged {
    
    [self.loaderIndicator startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{ [self callThirdPart]; });

}

- (void)callThirdPart {
    [self.viewModel callThirdPart:^{
            [self goToHome];
            [self.loaderIndicator stopAnimating];
        } splashCallback:^{
            [self routeToSplashView];
            [self.loaderIndicator stopAnimating];
        }];
}

- (void)goToHome {
    [self presentViewController: [self.router routeToHomeNavigationViewController]
                       animated:YES completion:NULL];
}

- (void)routeToSplashView {
    [self presentViewController:[self.router routeToSplashView] animated:YES completion:NULL];
    
}

@end
