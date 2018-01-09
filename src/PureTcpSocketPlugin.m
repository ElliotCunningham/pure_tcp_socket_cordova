//
//  PureTcpSocketPlugin.m
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import "PureTcpSocketPlugin.h"

@implementation PureTcpSocketPlugin


-(void)pluginInitialize {
    if (self != nil) {
        self.SharedSocketApi = SocketBackThreadApi.sharedSocketBackThreadApi;
    }
}

-(PureTcpSocketPlugin *)init {
    self = [super init];
    if (self != nil) {
        self.SharedSocketApi = SocketBackThreadApi.sharedSocketBackThreadApi;
    }
    return self;
}

+(PureTcpSocketPlugin *)sharedPureTcpSocketPlugin {
    static PureTcpSocketPlugin *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[PureTcpSocketPlugin alloc] init];
    });
    return sharedClass;
}

@end
