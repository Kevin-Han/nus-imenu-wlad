//
//  NUSWebService.h
//  User
//
//  Created by Yuan Xiao dan on 1/5/12.
//  Copyright (c) 2012 patty.1984@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@interface NUSWebService : NSObject
//-(void) processResponse:(NSMutableData *)data;
-(NSString *)getRespone:(NSString *) webServiceRequest;

-(NSString *)getLoginResponse:(NSString *) webServiceResponse;

-(NSMutableArray *) getStoreResponse:(NSString *) webServiceResponse;
@end
