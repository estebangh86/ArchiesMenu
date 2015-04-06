//
//  Persistance.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#define MR_SHORTHAND 1

#import <Foundation/Foundation.h>
#import <CoreData+MagicalRecord.h>
#import "Entity.h"
#import "CategoryEntity.h"
#import "Subcategory.h"
#import "Item.h"

@interface Persistance : NSObject

@property (strong, nonatomic) id response;
@property (strong, nonatomic) NSURL *documentsDirectory;

- (void)persistEntities;
- (void)persistDetails;
- (void)persistContent;

@end
