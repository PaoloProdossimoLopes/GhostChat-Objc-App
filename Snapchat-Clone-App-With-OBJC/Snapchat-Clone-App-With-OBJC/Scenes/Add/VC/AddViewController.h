//
//  AddViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseStorage/FirebaseStorage.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
    @property (strong, nonatomic) NSString* username;
@end

NS_ASSUME_NONNULL_END