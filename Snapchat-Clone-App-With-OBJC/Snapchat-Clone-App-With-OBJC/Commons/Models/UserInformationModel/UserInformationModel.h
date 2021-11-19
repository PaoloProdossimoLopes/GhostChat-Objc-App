//
//  UserInformationModel.h
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UserInformationModel;

@interface UserInformationModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *password;

- (instancetype)init:(NSString*)uid name:(NSString*)name email:(NSString*)email password:(NSString*)password;

- (NSDictionary*)getDictValue;

@end

NS_ASSUME_NONNULL_END
