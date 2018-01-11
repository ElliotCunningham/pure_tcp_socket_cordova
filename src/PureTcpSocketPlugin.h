//
//  PureTcpSocketPlugin.h
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 09/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "SocketBackThreadApi.h"

@interface PureTcpSocketPlugin : CDVPlugin {}

@property(nonatomic, strong) SocketBackThreadApi *SharedSocketApi;
@property(nonatomic, strong) JsContextApi *SharedJsContextApi;

-(void)connect:(CDVInvokedUrlCommand *)command;

-(void)sendDataToAConnexion:(CDVInvokedUrlCommand *)command;

-(void)getResponseFromAConnexion:(CDVInvokedUrlCommand *)command;

-(void)disconnectAndDeleteAConnexion:(CDVInvokedUrlCommand *)command;

+(PureTcpSocketPlugin *)sharedPureTcpSocketPlugin;

@end
