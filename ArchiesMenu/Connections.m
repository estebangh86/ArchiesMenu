//
//  Connections.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#define SERVER @"http://192.237.180.31/archies/public"
#define CATEGORIES_SERVICE @"category"
#define DETAILS_SEVICE @"details"
#define IMG_RESOURCES

#import "Connections.h"

@implementation Connections

- (id)init {
    
    self.persistance = [[Persistance alloc] init];
    
    return self;
}

// Obtiene entidades con AFNetworking en bloque asíncronamente
// Usa instancia de persistencia para entidades de los dos primeros niveles
// Itera las categorias para obtener detalles en el siguiente selector

- (void)getEntities {
    
    NSURL *url = [NSURL URLWithString:SERVER];
    
    url = [url URLByAppendingPathComponent:CATEGORIES_SERVICE];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[url absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        [self.persistance setResponse:responseObject];
        [self.persistance persistEntities];
        
        for (NSDictionary *category in responseObject)
            [self getDetails:category];
        
        //[self getDetails];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
}

// Usa instancia de persistencia para entidades en último nivel

- (void)getDetails:(NSDictionary *)category {
    
    NSURL *url = [NSURL URLWithString:SERVER];
    
    url = [url URLByAppendingPathComponent:CATEGORIES_SERVICE];
    url = [url URLByAppendingPathComponent:DETAILS_SEVICE];
    
    url = [url URLByAppendingPathComponent:[category objectForKey:@"id"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[url absoluteString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"JSON: %@", responseObject);
        [self.persistance setResponse:responseObject];
        [self.persistance persistDetails];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
}

// Selector de clase para poder persistir cualquier archivo dada la ruta
// Persiste archivos dentro de la carpeta de documentos

+ (void)getContent:(NSString *)path {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:SERVER];
    
    url = [url URLByAppendingPathComponent:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:path];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

@end
