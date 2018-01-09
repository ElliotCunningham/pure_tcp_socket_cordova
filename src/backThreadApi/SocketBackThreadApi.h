//
//  SocketBackThreadApi.h
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketApi.h"

@interface SocketBackThreadApi : NSObject

@property(nonatomic, strong) SocketApi *SharedSocketApi;

-(void)createConnexionWithAdress:(NSString *)adress AndPort:(NSString *)port;

-(void)disconnecteAndRemoveConnexion:(NSString *)adress;

-(void)sendData:(NSString *)data ToAConnexion:(NSString *)adress;

-(void)getResponse:(NSInteger *)resLength FromAConnexion:(NSString *)adress;


+(SocketBackThreadApi *)sharedSocketBackThreadApi;

@end
