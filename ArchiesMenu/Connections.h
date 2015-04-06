//
//  Connections.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Persistance.h"

@interface Connections : NSObject

@property (strong, nonatomic) Persistance *persistance;

- (void)getEntities;
+ (void)getContent:(NSString *)path;

@end
