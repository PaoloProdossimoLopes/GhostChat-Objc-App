//
//  CustomViewControllersProtocol.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

@protocol CustomViewControllersProtocol

@required
    - (void)commonInit;
    - (void)configureViewHierarchy;
    - (void)configureConstraints;
    - (void)configureStyle;

@optional
    - (void)initializeProperties;

@end
