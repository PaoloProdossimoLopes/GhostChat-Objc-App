//
//  HomeTableViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController()
    @property (strong, nonatomic) UIBarButtonItem * addButton;
    @property (strong, nonatomic) UIBarButtonItem *logoutButton;
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
    [self.viewModel getMessages: ^{ [self.tableView reloadData]; }];
}

#pragma mark - Selectors

- (void)addButtonHandleTapped {
    [[self navigationController]
     pushViewController: [[SnapChatAppRouter shared] routeToListOfContacts]
     animated:YES];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    
    UIViewController *vc = [[SnapChatAppRouter shared]
                            routeToMessageView:self.viewModel.messagesArray[indexPath.row]
                            key: self.viewModel.keys[indexPath.row]];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.getNumberOfRowInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel configureCell: indexPath];
}

@end

