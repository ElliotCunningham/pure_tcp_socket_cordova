//
//  JsContextApi.h
//  test
//
//  Created by Elliot Cunningham on 09/01/2018.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface JsContextApi : NSObject

@property(nonatomic, weak) NSObject<CDVCommandDelegate> *currentjsContext;

@property(nonatomic, weak) CDVInvokedUrlCommand *currentCommand;

-(void)setCurrentCommand:(CDVInvokedUrlCommand *)currentCommand;

-(void)setCurrentjsContext:(NSObject<CDVCommandDelegate> *)currentjsContext;

-(void)sendResponse:(NSString *)response;

-(void)sendError:(NSString *)errorString;

-(void)sendResponseArray:(NSArray *)responseArray;

-(void)sendResponseObject:(NSDictionary *)responseObject;

+(JsContextApi *)sharedJsContextApi;

@end
