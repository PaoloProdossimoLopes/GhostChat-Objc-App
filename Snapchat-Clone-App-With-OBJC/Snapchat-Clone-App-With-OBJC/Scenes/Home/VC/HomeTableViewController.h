//
//  HomeTableViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import <UIKit/UIKit.h>

#import <FirebaseAnalytics/FirebaseAnalytics.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

#import "ListOfContatcsTableViewController.h"
#import "MessageViewController.h"
#import "CustomViewControllersProtocol.h"
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewController : UITableViewController <CustomViewControllersProtocol>
    @property (strong, nonatomic) HomeViewModel *viewModel;
@end


NS_ASSUME_NONNULL_END
