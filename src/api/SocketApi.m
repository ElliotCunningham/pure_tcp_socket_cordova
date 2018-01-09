//
//  SocketApi.m
//  pure_tcp_socket
//
//  Created by Elliot Cunningham on 05/01/2018.
//  Copyright © 2018 Elliot Cunningham. All rights reserved.
//

#import "SocketApi.h"

@implementation SocketApi

-(void)createConnexionWithAdress:(NSString *)adress AndPort:(NSString *)port {
    FastSocket *connexion = [[FastSocket alloc] initWithHost:adress andPort:port];
    [connexion connect];
    [self addConnexionToConnexionArray:connexion];
}

-(void)connectAConnexion:(FastSocket *)connexion {
    [connexion connect];
    if (connexion.lastError != nil) {
        NSException *error = [NSException exceptionWithName:@"connect" reason:connexion.lastError.debugDescription userInfo:nil];
        @throw(error);
    }
}

-(void)closeAndDeleteConnexion:(NSString *)adress {
    FastSocket *connexion = [self getConnexionInConnexionArray:adress];
    [connexion close];
    [self deleteConnexionToConnexionArray:connexion];
}

-(void)sendData:(NSString *)data ToAConnexion:(NSString *)adress {
    FastSocket *connexion = [self getConnexionInConnexionArray:adress];
    if ([connexion isConnected] == NO) {
        [self connectAConnexion:connexion];
    }
    
    NSData *dataForSend = [self encodeToHexFromStringHex:data];
    
    long sending = [connexion sendBytes:[dataForSend bytes] count:[dataForSend length]];
    NSLog(@"sending %ld data", sending);
    
    if (connexion.lastError != nil) {
        NSException *error = [NSException exceptionWithName:@"error send data" reason:connexion.lastError.debugDescription userInfo:nil];
        @throw(error);
    }
}

-(NSString *)getResponse:(NSInteger *)resLength FromConnexion:(NSString *)adress {
    FastSocket *connexion = [self getConnexionInConnexionArray:adress];
    
    if ([connexion isConnected] == NO) {
        NSException *error = [NSException exceptionWithName:@"get response" reason:@"connexion is not connected unable to get response" userInfo:nil];
        @throw(error);
    }
    
    long length = (long)(int) resLength;
    char bytes[length];
    
    float timeout = 60000;
    [connexion setTimeout:timeout];
    [connexion receiveBytes:bytes limit:length];
    
    if (connexion.lastError != nil) {
        NSException *error = [NSException exceptionWithName:@"get response" reason:connexion.lastError.debugDescription userInfo:nil];
        @throw(error);
    }
    
    NSData *dataBytes = [NSData dataWithBytes:bytes length:length];
    NSString *response = [self decodeToStringHexFromDataBinary:dataBytes];
    
    return response;
}

-(void)addConnexionToConnexionArray:(FastSocket *)connexion {
    [_connexionArray addObject:connexion];
}

-(void)deleteConnexionToConnexionArray:(FastSocket *)connexion {
    [_connexionArray removeObject:connexion];
}

-(BOOL)checkIfConnexionExist:(NSString *)adress {
    BOOL test = NO;
    for (FastSocket *i in _connexionArray) {
        if ([i.host isEqualToString:adress]) {
            test = YES;
            break;
        }
    }
    return test;
}

-(FastSocket *)getConnexionInConnexionArray:(NSString *)adress {
    if ([self checkIfConnexionExist:adress] == NO) {
        NSException *error = [NSException exceptionWithName:@"get connexion in array" reason:@"no connection with this adress have been created" userInfo:nil];
        @throw(error);
    }
    int index = 0;
    for (int i = 0; i<[_connexionArray count]; i++) {
        if ([[_connexionArray objectAtIndex:i].host isEqualToString:adress]) {
            index = i;
            break;
        }
    }
    return [_connexionArray objectAtIndex:index];
}

-(NSData *)encodeToHexFromStringHex:(NSString *)dataString {
    NSMutableData *dataBinary = [[NSMutableData alloc] init];
    unsigned char whole_byte;
    
    char byte_chars[3] = {'\0', '\0', '\0'};
    
    for (int i=0; i<([dataString length]/2); i++) {
        byte_chars[0] = [dataString characterAtIndex:i*2];
        byte_chars[1] = [dataString characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [dataBinary appendBytes:&whole_byte length:1];
    }
    
    return dataBinary;
}

-(NSString *)decodeToStringHexFromDataBinary:(NSData *)binaryData {
    NSUInteger dataLength = [binaryData length];
    NSMutableString *dataString = [NSMutableString stringWithCapacity:dataLength*2];
    const unsigned char *dataBytes = [binaryData bytes];
    for (NSInteger idx = 0; idx < dataLength; ++idx) {
        [dataString appendFormat:@"%02x", dataBytes[idx]];
    }
    return dataString;
}

-(SocketApi *)init {
    self = [super init];
    if (self != nil) {
        self.connexionArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(SocketApi *)sharedSocketApi {
    static SocketApi *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[SocketApi alloc] init];
    });
    return sharedClass;
}

@end
