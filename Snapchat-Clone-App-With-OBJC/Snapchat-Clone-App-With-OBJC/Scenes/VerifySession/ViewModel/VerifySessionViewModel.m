//
//  VerifySessionViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "VerifySessionViewModel.h"

@implementation VerifySessionViewModel

- (void)callThirdPart: (void(^)(void))HomeCallback splashCallback:(void(^)(void))splashCallback {
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth * _Nonnull auth, FIRUser * _Nullable user) {
        if (user != nil) { HomeCallback(); }
        else { splashCallback(); }
    }];
}

@end
