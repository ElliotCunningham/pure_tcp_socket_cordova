//
//  SocketBackThreadApi.m
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import "SocketBackThreadApi.h"

@implementation SocketBackThreadApi

-(void)createConnexionWithAdress:(NSString *)adress AndPort:(NSString *)port {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            [_SharedSocketApi createConnexionWithAdress:adress AndPort:port];
            dispatch_async(dispatch_get_main_queue(), ^{
                // do something in principale thread;
            });
        } @catch(NSException *error) {
            NSLog(@"error async background connect %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
               // do something !!!!
            });
        }
    });
}

-(void)disconnecteAndRemoveConnexion:(NSString *)adress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            [_SharedSocketApi closeAndDeleteConnexion:adress];
            dispatch_async(dispatch_get_main_queue(), ^{
                // do something in main thread;
            });
        } @catch(NSException *error) {
            NSLog(@"error async background disconnect %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                // do something !!!!
            });
        }
    });
}

-(void)sendData:(NSString *)data ToAConnexion:(NSString *)adress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            [_SharedSocketApi sendData:data ToAConnexion:adress];
            dispatch_async(dispatch_get_main_queue(), ^{
                // do something in principale thread;
            });
        } @catch(NSException *error) {
            NSLog(@"error async background send data %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
               // do something !!!!
            });
        }
    });
}


-(void)getResponse:(NSInteger *)resLength FromAConnexion:(NSString *)adress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            NSString *response = [_SharedSocketApi getResponse:resLength FromConnexion:adress];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"response from %@ : %@", adress, response);
               // do something in main thread with response.
            });
        } @catch(NSException *error) {
            NSLog(@"error async background get data response %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
               //do something !!!!
            });
        }
    });
}


-(SocketBackThreadApi *)init {
    self = [super init];
    if (self != nil) {
        self.SharedSocketApi = SocketApi.sharedSocketApi;
    }
    
    return self;
}

+(SocketBackThreadApi *)sharedSocketBackThreadApi {
    static SocketBackThreadApi *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[SocketBackThreadApi alloc] init];
    });
    return sharedClass;
}

@end
