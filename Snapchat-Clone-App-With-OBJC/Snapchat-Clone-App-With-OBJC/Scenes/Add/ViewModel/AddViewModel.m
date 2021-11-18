//
//  AddViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "AddViewModel.h"

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import <FirebaseStorage/FirebaseStorage.h>

@implementation AddViewModel

- (void)saveDataOnFirebase: (NSString*)textFieldText username:(NSString*)username imagePlaceHoler:(UIImage*)imagePlaceholder callBack:(void(^)(void))completion {
    
    if (textFieldText.length <= 0 ) { return; }
    
    FIRUser * user = [FIRAuth auth].currentUser;
    FIRDatabaseReference * databaseRef = [[FIRDatabase database] reference];
    FIRDatabaseReference * reff = [databaseRef child:@"messages"];
    NSString * key = [reff childByAutoId].key;
    
    [self uploadImageToFirebase:key image:imagePlaceholder callBack:^(UIImage *callBack) {
        self.imagePlaceholder = callBack;
        completion();
    }];
    
    NSMutableDictionary * message = [[NSMutableDictionary alloc] init];
    
    [message setValue:user.uid forKey:@"sender"];
    [message setValue:username forKey:@"recipient"];
    [message setValue:textFieldText forKey:@"messageText"]; // add textfield here
    
    NSString* stringPath = [NSString stringWithFormat:@"/%@/", user.uid];
    
    NSDictionary *childUpdates = @{[stringPath stringByAppendingString:key]: message};
    
    [reff updateChildValues: childUpdates];
}


- (void)uploadImageToFirebase: (NSString*)key image:(UIImage*)imagePlaceholder
                     callBack:(void(^)(UIImage*))callBack {
    FIRStorageReference * storageRef = [[FIRStorage storage] reference];
    NSString *imagePath = [NSString stringWithFormat:@"/images/%@", key];
    
    FIRStorageReference *imageRef = [storageRef child: imagePath];
    
    NSData *imageData = UIImageJPEGRepresentation(imagePlaceholder, 0.5);
    
    FIRStorageMetadata *metaData = [FIRStorageMetadata new];
    metaData.contentType = @"image/jpeg";
    
    [imageRef putData: imageData metadata: metaData completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        if (error != nil) { NSLog(@"DEBUG: Error"); }
        else {
            NSLog(@"DEBUG: Success");
            callBack([UIImage imageNamed:@"addPhotoPlaceholder"]);
        }
    }];
    
}

@end
