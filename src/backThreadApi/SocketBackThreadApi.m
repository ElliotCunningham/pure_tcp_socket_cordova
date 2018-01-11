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
                [_SharedJsContextApi sendResponse:@"connected OK"];
            });
        } @catch(NSException *error) {
            NSLog(@"error async background connect %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendError:error.debugDescription];
            });
        }
    });
}

-(void)disconnecteAndRemoveConnexion:(NSString *)adress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            [_SharedSocketApi closeAndDeleteConnexion:adress];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendResponse:@"close connection and remove OK"];
            });
        } @catch(NSException *error) {
            NSLog(@"error async background disconnect %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendError:error.debugDescription];
            });
        }
    });
}

-(void)sendData:(NSString *)data ToAConnexion:(NSString *)adress {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        @try {
            [_SharedSocketApi sendData:data ToAConnexion:adress];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendResponse:@"send ok"];
            });
        } @catch(NSException *error) {
            NSLog(@"error async background send data %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendError:error.debugDescription];
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
                [_SharedJsContextApi sendResponse:response];
            });
        } @catch(NSException *error) {
            NSLog(@"error async background get data response %@", error.debugDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_SharedJsContextApi sendError:error.debugDescription];
            });
        }
    });
}


-(SocketBackThreadApi *)init {
    self = [super init];
    if (self != nil) {
        self.SharedSocketApi = SocketApi.sharedSocketApi;
        self.SharedJsContextApi = JsContextApi.sharedJsContextApi;
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
