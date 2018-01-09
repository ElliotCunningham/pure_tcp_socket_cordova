//
//  SocketApi.h
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 05/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastSocket/FastSocket.h>

@interface SocketApi : NSObject

@property(nonatomic, strong) NSMutableArray <FastSocket *> *connexionArray;


-(void)addConnexionToConnexionArray:(FastSocket *)connexion;

-(void)deleteConnexionToConnexionArray:(FastSocket *)connexion;

-(void)createConnexionWithAdress:(NSString *)adress AndPort:(NSString *)port;

-(void)closeAndDeleteConnexion:(NSString *)adress;

-(void)sendData:(NSString *)data ToAConnexion:(NSString *)adress;

-(void)connectAConnexion:(FastSocket *)connexion;

-(NSString *)getResponse:(NSInteger *)resLength FromConnexion:(NSString *)adress;

-(BOOL)checkIfConnexionExist:(NSString *)adress;

-(FastSocket *)getConnexionInConnexionArray:(NSString *)adress;

+(SocketApi *)sharedSocketApi;

@end
