//
//  ListOfContatcsTableViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "ListOfContatcsTableViewController.h"

@interface ListOfContatcsTableViewController ()
    @property (strong, nonatomic) NSMutableArray *recepientsArray;
@end

@implementation ListOfContatcsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"List of contatcs";
    [self getReceipts];
}

#pragma mark - Helpers

- (AddViewController*)routeToAddNew {
    AddViewController * vc = [[AddViewController alloc] init];
    return vc;
}

#pragma mark - API

- (void)getReceipts {
    
    FIRDatabaseReference * databaseRef = [[FIRDatabase database] reference];
    FIRDatabaseReference * userref = [databaseRef child:@"user"];
    
    [userref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSLog(@"Users retuned %@", snapshot.value);
        
        self.recepientsArray = [[NSMutableArray alloc] init];
        self.recepientsArray = [[snapshot.value allValues] mutableCopy];
        [self.tableView reloadData];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"DEBUG: error: %@", error.localizedDescription);
    }];
    
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    AddViewController * vc = [self routeToAddNew];
    vc.username = [[self.recepientsArray objectAtIndex: indexPath.row] objectForKey:@"name"];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recepientsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

@end
