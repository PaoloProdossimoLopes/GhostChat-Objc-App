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

#import "CustomViewControllersProtocol.h"

#import "AddViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController <CustomViewControllersProtocol, UINavigationControllerDelegate,  UIImagePickerControllerDelegate>
    @property (strong, nonatomic) AddViewModel *viewModel;
    @property (strong, nonatomic) NSString* username;
@end

NS_ASSUME_NONNULL_END
