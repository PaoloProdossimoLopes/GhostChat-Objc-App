//
//  SignInViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <Foundation/Foundation.h>
#import "FirebaseAuth/FirebaseAuth.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInViewModel : NSObject
- (void)checkIfUserAlreadyRegistered: (NSString*)email password:(NSString*)password
                   successCompletion:(void(^)(void))successCompletion
                   failureCompletion:(void(^)(NSError*))failureCompletion;
@end

NS_ASSUME_NONNULL_END
