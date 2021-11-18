//
//  SignUpViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "SignUpViewModel.h"

@implementation SignUpViewModel

- (void)saveOnDataBase:(FIRUser*)user userInformation:(NSDictionary*)userInformation
     successCompletion:(void(^)(void))successCompletion
     failureCompletion: (void(^)(NSError*))failureCompletion {
    
    FIRDatabaseReference* database = [[FIRDatabase database] reference];
    FIRDatabaseReference* userReference = [[database child: @"user"] child: user.uid];
    
    [userReference setValue: userInformation withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (error == nil) { successCompletion(); }
        else { failureCompletion(error); }
    }];
    
}


- (void)registerNewAccountInFirebase: (NSDictionary*)dict
                   successCompletion:(void(^)(FIRAuthDataResult*))successCompletion
                   failureCompletion:(void(^)(NSError*))failureCompletion {
    
    [[FIRAuth auth] createUserWithEmail: dict[@"email"]
                               password: dict[@"password"]
                             completion:^(FIRAuthDataResult * _Nullable authResult,
                                          NSError * _Nullable error) {
        
        if (error == nil) { successCompletion(authResult); }
        else { failureCompletion(error); }
        
    }];
}

@end
