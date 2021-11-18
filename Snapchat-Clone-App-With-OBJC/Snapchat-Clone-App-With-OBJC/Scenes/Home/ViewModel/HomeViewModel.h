//
//  HomeViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseAuth/FirebaseAuth.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

    //Propertirs
    @property (strong, nonatomic) NSMutableArray * messagesArray;
    @property (strong, nonatomic) NSArray<NSString*> * keys;

    //Methods
    - (void)getMessages: (void(^)(void))callBack;
    - (int)getNumberOfRowInSection;
    - (UITableViewCell*)configureCell:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
