//
//  SignInViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "SignInViewModel.h"

@implementation SignInViewModel

- (void)checkIfUserAlreadyRegistered: (NSString*)email
                            password:(NSString*)password
                   successCompletion:(void(^)(void))successCompletion
                   failureCompletion:(void(^)(NSError*))failureCompletion {
    
    BOOL isValid = (email.length > 0 && password.length > 0);
    
    if (!isValid) {
        failureCompletion([[NSError alloc]init]);
        return ;
    }
    
    [[FIRAuth auth] signInWithEmail: email password: password
                         completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        
        if (error == nil) { successCompletion(); }
        else { failureCompletion(error); }
    }];
    
}

@end
