//
//  ListOfContatctsViewModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "ListOfContatctsViewModel.h"

@implementation ListOfContatctsViewModel

- (UITableViewCell*)configureTableViewCell:(NSIndexPath*)indexPath {
    UITableViewCell * cell = [[UITableViewCell alloc] init];

    //Dowloading receiptians
    if (self.recepientsArray == nil) {
        cell.textLabel.text = @"Loading ...";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

    } else if (self.recepientsArray.count == 0) { //0 recepants
        cell.textLabel.text = @"Sory, there's nobody avaliable to send message to :(";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

    } else {
        NSDictionary * userInfo = [self.recepientsArray objectAtIndex: indexPath.row];
        cell.textLabel.text = [userInfo objectForKey:@"name"];
        cell.detailTextLabel.text = [userInfo objectForKey: @"email"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}


- (void)getReceipts: (void(^)(void))completion {
    
    FIRDatabaseReference * databaseRef = [[FIRDatabase database] reference];
    FIRDatabaseReference * userref = [databaseRef child:@"user"];
    
    [userref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSLog(@"Users retuned %@", snapshot.value);
        
        self.recepientsArray = [[NSMutableArray alloc] init];
        self.recepientsArray = [[snapshot.value allValues] mutableCopy];
        completion();
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"DEBUG: error: %@", error.localizedDescription);
    }];
    
}

@end
