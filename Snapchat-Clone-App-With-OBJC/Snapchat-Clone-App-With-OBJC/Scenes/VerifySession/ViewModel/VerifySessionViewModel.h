//
//  VerifySessionViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <Foundation/Foundation.h>
#import <FirebaseAuth/FirebaseAuth.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifySessionViewModel : NSObject
- (void)callThirdPart: (void(^)(void))HomeCallback splashCallback:(void(^)(void))splashCallback;
@end

NS_ASSUME_NONNULL_END
