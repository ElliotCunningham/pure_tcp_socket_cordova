//
//  JsContextApi.m
//  test
//
//  Created by Elliot Cunningham on 09/01/2018.
//

#import "JsContextApi.h"

@implementation JsContextApi

-(void)setCurrentjsContext:(NSObject<CDVCommandDelegate> *)currentjsContext {
    self.currentjsContext = currentjsContext;
}

-(void)setCurrentCommand:(CDVInvokedUrlCommand *)currentCommand {
    self.currentCommand = currentCommand;
}

-(void)sendResponse:(NSString *)response{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:response];
    [_currentjsContext sendPluginResult:result callbackId:_currentCommand.callbackId];
}

-(void)sendResponseArray:(NSArray *)responseArray {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:responseArray];
    [_currentjsContext sendPluginResult:result callbackId:_currentCommand.callbackId];
}

-(void)sendResponseObject:(NSDictionary *)responseObject {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:responseObject];
    [_currentjsContext sendPluginResult:result callbackId:_currentCommand.callbackId];
}

-(void)sendError:(NSString *)errorString {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:errorString];
    [_currentjsContext sendPluginResult:result callbackId:_currentCommand.callbackId];
}

+(JsContextApi *)sharedJsContextApi {
    static JsContextApi *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[JsContextApi alloc] init];
    });
    return sharedClass;
}

@end
