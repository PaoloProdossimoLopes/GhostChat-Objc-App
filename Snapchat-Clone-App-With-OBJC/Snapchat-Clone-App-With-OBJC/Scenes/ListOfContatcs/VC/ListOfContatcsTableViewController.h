//
//  ListOfContatcsTableViewController.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import <UIKit/UIKit.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

#import "ListOfContatctsViewModel.h"
#import "AddViewController.h"
#import "AddViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListOfContatcsTableViewController : UITableViewController
    @property (strong, nonatomic) ListOfContatctsViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
