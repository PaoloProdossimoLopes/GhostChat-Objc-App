//
//  ListOfContatcsTableViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "ListOfContatcsTableViewController.h"
#import "AddViewModel.h"

@interface ListOfContatcsTableViewController ()
//    @property (strong, nonatomic) NSMutableArray *recepientsArray;
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
    AddViewModel *viewModel = [[AddViewModel alloc] init];
    
    vc.viewModel = viewModel;
    
    return vc;
}

#pragma mark - API

- (void)getReceipts {
    
    [self.viewModel getReceipts:^{
        [self.tableView reloadData];
    }];
    
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    AddViewController * vc = [self routeToAddNew];
    vc.username = [[self.viewModel.recepientsArray
                    objectAtIndex: indexPath.row] objectForKey:@"name"];
    [[self navigationController] pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.recepientsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.viewModel configureTableViewCell:indexPath];
}

@end
