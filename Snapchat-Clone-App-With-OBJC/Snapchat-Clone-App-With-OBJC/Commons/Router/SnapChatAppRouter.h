//
//  SnapChatAppRouter.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//
#import <UIKit/UIKit.h>

@interface SnapChatAppRouter : NSObject
+ (id) shared ;
- (UINavigationController*)routeToHomeNavigationViewController;
- (UINavigationController*)routeToSplashView ;
- (UIViewController*)routeToSignUpView;
- (UIViewController*)routeToSignInView;
- (UIViewController*)routeToMessageView:(NSMutableArray*)message key:(NSString*)key;
- (UIViewController*)routeToListOfContacts;
@end
