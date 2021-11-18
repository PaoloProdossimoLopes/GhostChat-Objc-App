//
//  MessageViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageViewController : UIViewController
    @property (strong, nonatomic) NSMutableArray *messageArray;
    @property (strong, nonatomic) NSString *keys;
@end

NS_ASSUME_NONNULL_END
