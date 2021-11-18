//
//  HomeTableViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "HomeTableViewController.h"

@import Firebase;

@interface HomeTableViewController()
    @property (strong, nonatomic) UIBarButtonItem * addButton;
    @property (strong, nonatomic) UIBarButtonItem *logoutButton;

    @property (strong, nonatomic) NSMutableArray * messagesArray;
    @property (strong, nonatomic) NSArray<NSString*> * keys;
@end

@implementation HomeTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [FIRAnalytics logEventWithName:kFIRParameterContent
                        parameters:@{kFIRParameterItemID: @"HomeViewController",
                                     kFIRParameterItemName: @"HomeViewController"}];
    [self getMessages];
    [self commonInit];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - CustomViewControllerprotocol

- (void)commonInit {
    [self initializeProperties];
    [self configureViewHierarchy];
    [self configureConstraints];
    [self configureStyle];
    [self configureAction];
}

- (void)initializeProperties {
    self.addButton = [[UIBarButtonItem alloc] init];
    self.logoutButton = [[UIBarButtonItem alloc] init];
}

- (void)configureViewHierarchy {
    self.navigationItem.rightBarButtonItem = self.addButton;
    self.navigationItem.leftBarButtonItem = self.logoutButton;
}

- (void)configureConstraints { }

- (void)configureStyle {
    self.title = @"Home";
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.addButton.tintColor = UIColor.blackColor;
    [self.addButton setImage: [UIImage systemImageNamed:@"plus"]];
    
    self.logoutButton.tintColor = UIColor.orangeColor;
    [self.logoutButton setTitle:@"Logout"];
    
}

#pragma mark - Helpers

- (void)configureAction {
    [self.addButton setTarget: self];
    [self.addButton setAction:@selector(addButtonHandleTapped)];
    
    [self.logoutButton setTarget: self];
    [self.logoutButton setAction:@selector(logoutFirebaseSession)];
}

- (void)logoutFirebaseSession {
    [[FIRAuth auth] signOut: NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)getMessages {
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
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark - Selectors

- (void)addButtonHandleTapped {
    NSLog(@"DEBUG: Button tapped!");
    UIViewController * vc = [[ListOfContatcsTableViewController alloc] init];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    
    MessageViewController *vc = [[MessageViewController alloc] init];
    
    vc.messageArray = self.messagesArray[indexPath.row];
    vc.keys = self.keys[indexPath.row];
    
    [[self navigationController] pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.messagesArray.count > 0) { return self.messagesArray.count; } else { return 0; }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

