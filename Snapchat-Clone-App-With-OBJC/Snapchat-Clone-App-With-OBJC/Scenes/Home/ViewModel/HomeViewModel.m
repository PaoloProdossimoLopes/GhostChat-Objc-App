//
//  HomeViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)getMessages: (void(^)(void))callBack {
    NSString *userID = [FIRAuth auth].currentUser.uid;
    FIRDatabaseReference *dataBaseRef = [[FIRDatabase database] reference];
    FIRDatabaseQuery *messageQuery = [[dataBaseRef child:@"messages"] child:userID];
    FIRDatabaseReference *ref = messageQuery.ref;
    
    [ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if (snapshot.value == [NSNull null]) {
            return;
        }
        
        NSDictionary *dict = snapshot.value;
        NSString *key = snapshot.key;
        
        self.messagesArray = [NSMutableArray array];
        self.messagesArray = [[dict allValues] mutableCopy];
        
        self.keys = [[NSArray<NSString*> alloc] init];
        self.keys = [dict allKeys];
        
        NSLog(@"DEBUG: Get message dict %@ key %@", dict, key);
        NSLog(@"DEBUG: MessageArray %@", [self.messagesArray valueForKey:@"messageText"]);
        
        callBack();
    }];
}

- (int)getNumberOfRowInSection {
    if (self.messagesArray.count > 0) { return (int)self.messagesArray.count; }
    else { return 0; }
}

- (UITableViewCell*)configureCell:(NSIndexPath*)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]
                                 initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:@"MessageCell"];
    
    //Dowloading receiptians
    if (self.messagesArray == nil) {
        cell.textLabel.text = @"Loading ...";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

    } else if (self.messagesArray.count == 0) { //0 recepants
        cell.textLabel.text = @"Sory, there's nobody avaliable to send message to :(";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

    } else {
        NSDictionary * userInfo = [self.messagesArray objectAtIndex: indexPath.row];
        cell.textLabel.text = [userInfo objectForKey:@"messageText"];
        cell.detailTextLabel.text = [userInfo objectForKey: @"recipient"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

@end
