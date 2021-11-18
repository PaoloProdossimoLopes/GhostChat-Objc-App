//
//  MessageViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "MessageViewController.h"

@interface MessageViewController()
    @property (strong, nonatomic) UIImageView *imageMessageView;
    @property (strong, nonatomic) UILabel *messageLabel;
    @property (strong, nonatomic) UIActivityIndicatorView *loaderIndicator;
@end

@implementation MessageViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

#pragma mark - Helpers

- (void)commonInit {
    [self initializeProperties];
    
    [self getImageFromFirebaseStorage];
    
    [self configureViewHierachy];
    [self configureConstraints];
    [self configureStyle];
}

- (void)initializeProperties {
    self.imageMessageView = [[UIImageView alloc]init];
    self.messageLabel = [[UILabel alloc]init];
    self.loaderIndicator = [[UIActivityIndicatorView alloc] init];
}

- (void)configureViewHierachy {
    
    NSArray<UIView*> *properties = @[self.loaderIndicator, self.imageMessageView, self.messageLabel];
    for (UIView* view in properties) {
        view.translatesAutoresizingMaskIntoConstraints = false;
        [self.view addSubview: view];
    }
}

- (void)configureConstraints {
    [NSLayoutConstraint activateConstraints: @[
        
        //loaderView
        [self.loaderIndicator.centerYAnchor
         constraintEqualToAnchor: self.view.centerYAnchor constant: -20],
        [self.loaderIndicator.centerXAnchor
         constraintEqualToAnchor: self.view.centerXAnchor],
        [self.loaderIndicator.heightAnchor constraintEqualToConstant: 200],
        [self.loaderIndicator.widthAnchor constraintEqualToConstant: 200],
        
        //ImageMessageView
        [self.imageMessageView.centerYAnchor
         constraintEqualToAnchor: self.view.centerYAnchor constant: -20],
        [self.imageMessageView.centerXAnchor
         constraintEqualToAnchor: self.view.centerXAnchor],
        [self.imageMessageView.heightAnchor constraintEqualToConstant: 200],
        [self.imageMessageView.widthAnchor constraintEqualToConstant: 200],
        
        //MessageLabel
        [self.messageLabel.topAnchor
         constraintEqualToAnchor: self.imageMessageView.bottomAnchor constant: 30],
        [self.messageLabel.centerXAnchor
         constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)configureStyle {
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = [NSString stringWithFormat: @"From: %@",
                  [self.messageArray valueForKey:@"recipient"]];
    self.messageLabel.text = [self.messageArray valueForKey: @"messageText"];
    self.imageMessageView.backgroundColor = UIColor.clearColor;
}

#pragma mark - API

- (void)getImageFromFirebaseStorage {
    [self.loaderIndicator startAnimating];
    
    [self.viewModel getImageFromFirebaseStorage: self.keys messageArray: self.messageArray sucsessCompletion:^(UIImage *image) {
        self.imageMessageView.image = image;
        [self.loaderIndicator stopAnimating];
    } failureCompletion:^{
        self.imageMessageView.image = [UIImage imageNamed: @"addPhotoPlaceholder"];
        [self.loaderIndicator stopAnimating];
    }];
}

@end
