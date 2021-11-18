//
//  MessageViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseStorage/FirebaseStorage.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewModel : NSObject
- (void)getImageFromFirebaseStorage: (NSString*)keys
                       messageArray:(NSMutableArray*)messageArray
                  sucsessCompletion:(void(^)(UIImage*))sucsessCompletion
                  failureCompletion:(void(^)(void))failureCompletionfailureCompletion;
@end

NS_ASSUME_NONNULL_END
