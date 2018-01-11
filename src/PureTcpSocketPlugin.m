//
//  PureTcpSocketPlugin.m
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import "PureTcpSocketPlugin.h"

@implementation PureTcpSocketPlugin

-(void)connect:(CDVInvokedUrlCommand *)command {
    NSString *adress = [command.arguments objectAtIndex:0];
    NSString *port = [command.arguments objectAtIndex:1];

    [_SharedJsContextApi setCurrentCommand:command];
    [_SharedJsContextApi setCurrentjsContext:self.commandDelegate];
    [_SharedSocketApi createConnexionWithAdress:adress AndPort:port];
}

-(void)sendDataToAConnexion:(CDVInvokedUrlCommand *)command {
    NSString *data = [command.arguments objectAtIndex:0];
    NSString *adress = [command.arguments objectAtIndex:1];

    [_SharedJsContextApi setCurrentCommand:command];
    [_SharedJsContextApi setCurrentjsContext:self.commandDelegate];
    [_SharedSocketApi sendData:data ToAConnexion:adress];
}

-(void)getResponseFromAConnexion:(CDVInvokedUrlCommand *)command {
    NSString *stringResLength = [command.arguments objectAtIndex:0];
    NSString *adress = [command .arguments objectAtIndex:1];
    int resLength = [stringResLength intValue];

    [_SharedJsContextApi setCurrentCommand:command];
    [_SharedJsContextApi setCurrentjsContext:self.commandDelegate];
    [_SharedSocketApi getResponse:&resLength FromAConnexion:adress];
}

-(void)disconnectAndDeleteAConnexion:(CDVInvokedUrlCommand *)command {
    NSString *adress = [command.arguments objectAtIndex:0];

    [_SharedJsContextApi setCurrentCommand:command];
    [_SharedJsContextApi setCurrentjsContext:self.commandDelegate];
    [_SharedSocketApi disconnecteAndRemoveConnexion:adress];
}


-(void)pluginInitialize {
    if (self != nil) {
        self.SharedSocketApi = SocketBackThreadApi.sharedSocketBackThreadApi;
    }
}

-(PureTcpSocketPlugin *)init {
    self = [super init];
    if (self != nil) {
        self.SharedSocketApi = SocketBackThreadApi.sharedSocketBackThreadApi;
        self.SharedJsContextApi = JsContextApi.sharedJsContextApi;
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
