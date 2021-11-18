//
//  MessageViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "MessageViewModel.h"

@implementation MessageViewModel

- (void)getImageFromFirebaseStorage: (NSString*)keys
                       messageArray:(NSMutableArray*)messageArray
                  sucsessCompletion:(void(^)(UIImage*))sucsessCompletion
                  failureCompletion:(void(^)(void))failureCompletionfailureCompletion {
    
    FIRStorageReference *ref = [[FIRStorage storage] reference];
    NSString *imagePath = [NSString stringWithFormat: @"/images/%@", keys];
    FIRStorageReference *imageRef = [ref child: imagePath];
    [imageRef dataWithMaxSize:(5 * 1024 * 1024) completion:^(NSData * _Nullable data, NSError * _Nullable error) {
            if (error == nil && data != nil) {
//                self.imageMessageView.image = [[UIImage alloc]initWithData: data];
                sucsessCompletion([[UIImage alloc]initWithData: data]);
            } else {
//                NSLog(@"DEBUG: Error %@", error.localizedDescription);
//                self.imageMessageView.image = [[UIImage alloc] init];
                failureCompletionfailureCompletion();
            }
    }];
}

@end
