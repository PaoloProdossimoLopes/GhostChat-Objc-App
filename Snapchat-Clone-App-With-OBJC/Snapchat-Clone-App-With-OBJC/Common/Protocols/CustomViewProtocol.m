//
//  CustomViewProtocol.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 17/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomViewProtocol <UIViewController>

    @required
    - (void) configureViewHierarchy;
    - (void) configureConstraints;

    @optional
    - (void) condigureStyle;
    - (void)commonInit;

@end

@interface NSObject(CustomViewProtocol)

@end

- (void)commonInit {
    configureView
}

@implementation NSObject(CustomViewProtocol)

- (void)commonInit {
    
}

@end

NS_ASSUME_NONNULL_END
