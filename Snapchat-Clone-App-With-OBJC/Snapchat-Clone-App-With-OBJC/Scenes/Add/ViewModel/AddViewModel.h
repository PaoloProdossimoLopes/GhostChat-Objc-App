//
//  AddViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <UIKit/UIKit.h>

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseStorage/FirebaseStorage.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddViewModel : NSObject

@property (strong, nonatomic) UIImage *imagePlaceholder;

- (void)saveDataOnFirebase: (NSString*)textFieldText username:(NSString*)username imagePlaceHoler:(UIImage*)imagePlaceholder callBack:(void(^)(void))completion;

@end


NS_ASSUME_NONNULL_END
