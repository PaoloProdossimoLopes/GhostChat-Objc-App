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
@end

@implementation AddViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

#pragma mark - Helpers

- (void)commonInit {
    self.view.backgroundColor = UIColor.orangeColor;
    
    [self confgureNavigationBar];
    [self configureImagePlaceholder];
    
    self.addNote = [[UITextField alloc] init];
    self.sendAMessage = [[UIButton alloc] init];
    
    NSArray<UIView*> * lisOfViews = @[self.sendAMessage, self.addNote];
    
    for ( UIView *item in lisOfViews) {
        item.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview: item];
    }
    
    [self configureAddNoteButton];
    [self configureSendAMessageButton];
}

- (void)confgureNavigationBar {
    self.title = self.username;
    self.navigationController.navigationBar.tintColor = UIColor.blackColor;
}

- (void)configureImagePlaceholder {
    self.imageViewPlaceholder = [[UIImageView alloc] init];
    
    self.imageViewPlaceholder.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageViewPlaceholder.backgroundColor = UIColor.blackColor;
    self.imageViewPlaceholder.layer.cornerRadius = imageViewSize/2;
    
    [self.view addSubview: self.imageViewPlaceholder];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.imageViewPlaceholder.topAnchor
            constraintEqualToAnchor: self.view.safeAreaLayoutGuide.topAnchor constant: 50],
        [self.imageViewPlaceholder.centerXAnchor
            constraintEqualToAnchor: self.view.centerXAnchor],
        [self.imageViewPlaceholder.widthAnchor
            constraintEqualToConstant: imageViewSize],
        [self.imageViewPlaceholder.heightAnchor
            constraintEqualToConstant: imageViewSize],
    ]];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget: self
                                       action:@selector(adddButtonHandleTapped)];
    [self.imageViewPlaceholder addGestureRecognizer:tap];
    self.imageViewPlaceholder.userInteractionEnabled = YES;
}

- (void)configureAddNoteButton {
    
    UIView* leftView = [[UIView alloc] init];
    leftView.translatesAutoresizingMaskIntoConstraints = false;
    [leftView.widthAnchor constraintEqualToConstant:10].active = YES;
    
    self.addNote.placeholder = @"add here some message";
    
    self.addNote.leftView = leftView;
    self.addNote.leftViewMode = UITextFieldViewModeAlways;
    
    self.addNote.rightView = leftView;
    self.addNote.rightViewMode = UITextFieldViewModeAlways;
    
    self.addNote.backgroundColor = UIColor.whiteColor;
    self.addNote.layer.cornerRadius = 5;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.addNote.topAnchor
         constraintEqualToAnchor: self.imageViewPlaceholder.bottomAnchor constant: 50],
        [self.addNote.widthAnchor constraintEqualToConstant: self.view.frame.size.width - 40],
        [self.addNote.heightAnchor constraintEqualToConstant:80],
        [self.addNote.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor]
    ]];
    
}

- (void)configureSendAMessageButton {
    
    [self.sendAMessage setTitle:@"Send a message" forState: UIControlStateNormal];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.sendAMessage.topAnchor
         constraintEqualToAnchor: self.addNote.bottomAnchor constant:50],
        [self.sendAMessage.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
    
    [self.sendAMessage addTarget: self
                          action: @selector(sendAMessageButtonAndleTapped)
                forControlEvents: UIControlEventTouchUpInside];
}

#pragma mark - Selectors

- (void)adddButtonHandleTapped {
    NSLog(@"Add button handle tapped");
    
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [self presentViewController: picker animated:YES completion: NULL];
    
}

- (void)addNoteButtonAndleTapped {
    NSLog(@"Add note button handle tapped");
}

- (void)sendAMessageButtonAndleTapped {
    NSLog(@"send a message button handle tapped");
    [self saveMessageToFirebase];
}

- (void)saveMessageToFirebase {
    
    if (self.addNote.text.length <= 0 ) { return; }
    
    FIRUser * user = [FIRAuth auth].currentUser;
    FIRDatabaseReference * databaseRef = [[FIRDatabase database] reference];
    FIRDatabaseReference * reff = [databaseRef child:@"messages"];
    NSString * key = [reff childByAutoId].key;
    
    
    [self uploadImageToFirebase:key];
    
    NSMutableDictionary * message = [[NSMutableDictionary alloc] init];
    
    [message setValue:user.uid forKey:@"sender"];
    [message setValue:self.username forKey:@"recipient"];
    [message setValue:self.addNote.text forKey:@"messageText"]; // add textfield here
    
    NSString* stringPath = [NSString stringWithFormat:@"/%@/", user.uid];
    
    NSDictionary *childUpdates = @{[stringPath stringByAppendingString:key]: message};
    
    [reff updateChildValues: childUpdates];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)uploadImageToFirebase: (NSString*)key {
    FIRStorageReference * storageRef = [[FIRStorage storage] reference];
    NSString *imagePath = [NSString stringWithFormat:@"/images/%@", key];
    
    FIRStorageReference *imageRef = [storageRef child: imagePath];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageViewPlaceholder.image, 0.5);
    
    FIRStorageMetadata *metaData = [FIRStorageMetadata new];
    metaData.contentType = @"image/jpeg";
    
    [imageRef putData:imageData metadata:metaData completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"DEBUG: Error %@", error.localizedDescription);
            } else {
                NSLog(@"DEBUG: Success");
            }
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
