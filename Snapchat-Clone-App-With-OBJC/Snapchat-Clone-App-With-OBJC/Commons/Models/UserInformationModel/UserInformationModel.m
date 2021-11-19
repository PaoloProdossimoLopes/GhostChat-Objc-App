//
//  UserInformationModel.m
//  Snapchat-Clone-App-With-OBJC
//
//  Created by Paolo Prodossimo Lopes on 18/11/21.
//

#import "UserInformationModel.h"

@implementation UserInformationModel

- (instancetype)init:(NSString*)uid name:(NSString*)name email:(NSString*)email password:(NSString*)password {
    
    self.uid = uid;
    self.name = name;
    self.email = email;
    self.password = password;
    
    return self;
}

- (NSDictionary*)getDictValue {
    NSDictionary *dict = @{
        @"uid": self.uid,
        @"name": self.name,
        @"email": self.email,
        @"password": self.password
    };
    return dict;
}

@end
