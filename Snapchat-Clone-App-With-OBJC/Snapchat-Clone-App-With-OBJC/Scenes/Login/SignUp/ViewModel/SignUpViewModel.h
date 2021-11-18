//
//  SignUpViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <Foundation/Foundation.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignUpViewModel : NSObject
- (void)saveOnDataBase:(FIRUser*)user userInformation:(NSDictionary*)userInformation
     successCompletion:(void(^)(void))successCompletion
     failureCompletion: (void(^)(NSError*))failureCompletion;

- (void)registerNewAccountInFirebase: (NSDictionary*)dict
                   successCompletion:(void(^)(FIRAuthDataResult*))successCompletion
                   failureCompletion:(void(^)(NSError*))failureCompletion;
@end

NS_ASSUME_NONNULL_END
