//
//  AddViewController.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import "AddViewController.h"

#pragma mark - Constants

CGFloat imageViewSize = 300;

@interface AddViewController()
    @property (strong, nonatomic) UITextField * addNote;
    @property (strong, nonatomic) UIButton * sendAMessage;
    @property (strong, nonatomic) UIImageView * imageViewPlaceholder;

    @property (strong, nonatomic) UIView* leftView;
@end

@implementation AddViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

#pragma mark - CustomViewControllersProtocol

- (void)commonInit {
    [self initializeProperties];
    [self configureViewHierarchy];
    [self configureConstraints];
    [self configureStyle];
    [self configureActions];
}

- (void)initializeProperties {
    self.leftView = [[UIView alloc] init];
    self.addNote = [[UITextField alloc] init];
    self.sendAMessage = [[UIButton alloc] init];
    self.imageViewPlaceholder = [[UIImageView alloc] init];
    self.imageViewPlaceholder.image = [UIImage imageNamed:@"addPhotoPlaceholder"];
}

- (void)configureViewHierarchy {
    NSArray<UIView*> * lisOfViews = @[self.sendAMessage, self.addNote,
                                      self.imageViewPlaceholder];
    
    for ( UIView *item in lisOfViews) {
        item.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview: item];
    }
}

- (void)configureConstraints {

    self.leftView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.imageViewPlaceholder.topAnchor
         constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant: 50],
        [self.imageViewPlaceholder.centerXAnchor
         constraintEqualToAnchor: self.view.centerXAnchor],
        [self.imageViewPlaceholder.widthAnchor
         constraintEqualToConstant: imageViewSize],
        [self.imageViewPlaceholder.heightAnchor
         constraintEqualToConstant: imageViewSize],
        
        [self.leftView.widthAnchor constraintEqualToConstant:10],
        
        [self.addNote.topAnchor
         constraintEqualToAnchor: self.imageViewPlaceholder.bottomAnchor constant: 50],
        [self.addNote.widthAnchor constraintEqualToConstant: self.view.frame.size.width - 40],
        [self.addNote.heightAnchor constraintEqualToConstant: 50],
        [self.addNote.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        
        [self.sendAMessage.topAnchor
         constraintEqualToAnchor: self.addNote.bottomAnchor constant:50],
        [self.sendAMessage.heightAnchor constraintEqualToConstant:50],
        [self.sendAMessage.widthAnchor constraintEqualToConstant:200],
        [self.sendAMessage.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}


- (void)configureStyle {
    
    self.title = [NSString stringWithFormat: @"To: %@", self.username];
    self.navigationController.navigationBar.tintColor = UIColor.blackColor;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.imageViewPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewPlaceholder.clipsToBounds = true;
    self.imageViewPlaceholder.backgroundColor = UIColor.blackColor;
    self.imageViewPlaceholder.layer.cornerRadius = imageViewSize/2;
    
    self.addNote.placeholder = @"add here some message";
    self.addNote.leftView = self.leftView;
    self.addNote.leftViewMode = UITextFieldViewModeAlways;
    self.addNote.rightView = self.leftView;
    self.addNote.rightViewMode = UITextFieldViewModeAlways;
    self.addNote.backgroundColor = UIColor.systemGray5Color;
    self.addNote.layer.cornerRadius = 5;
    
    [self.sendAMessage setTitleColor: UIColor.whiteColor forState: UIControlStateNormal];
    [self.sendAMessage setTitle:@"Send a message" forState: UIControlStateNormal];
    self.sendAMessage.backgroundColor = UIColor.orangeColor;
    
    self.sendAMessage.layer.cornerRadius = 50/2;
}

#pragma mark - Helpers

- (void)configureActions {
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(adddButtonHandleTapped)];
    [self.imageViewPlaceholder addGestureRecognizer:tap];
    self.imageViewPlaceholder.userInteractionEnabled = YES;
    
    [self.sendAMessage addTarget: self action: @selector(sendAMessageButtonAndleTapped)
                forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Selectors

- (void)adddButtonHandleTapped {
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [self presentViewController: picker animated:YES completion: NULL];
}

- (void)sendAMessageButtonAndleTapped {
    [self saveMessageToFirebase];
}

#pragma mark - API

- (void)saveMessageToFirebase {
    
    [self.viewModel saveDataOnFirebase:self.addNote.text username:self.username imagePlaceHoler:self.imageViewPlaceholder.image callBack:^{
            self.imageViewPlaceholder.image = self.viewModel.imagePlaceholder;
            [[self navigationController] popToRootViewControllerAnimated:YES];
    }];
}


#pragma mark - UIPickerViewDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    UIImage* templateImage = info[UIImagePickerControllerOriginalImage];
    
    self.imageViewPlaceholder.image = templateImage;
    self.imageViewPlaceholder.clipsToBounds = true;
    self.imageViewPlaceholder.layer.borderColor = UIColor.whiteColor.CGColor;
    self.imageViewPlaceholder.layer.borderWidth = 4;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
