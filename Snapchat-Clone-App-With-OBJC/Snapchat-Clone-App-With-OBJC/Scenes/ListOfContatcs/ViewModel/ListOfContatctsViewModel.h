//
//  ListOfContatctsViewModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListOfContatctsViewModel : NSObject
    @property (strong, nonatomic) NSMutableArray *recepientsArray;

    - (void)getReceipts: (void(^)(void))completion;
    - (UITableViewCell*)configureTableViewCell:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
