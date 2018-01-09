//
//  PureTcpSocketPlugin.h
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketBackThreadApi.h"

@interface PureTcpSocketPlugin : NSObject

@property(nonatomic, strong) SocketBackThreadApi *SharedSocketApi;

+(PureTcpSocketPlugin *)sharedPureTcpSocketPlugin;

@end
