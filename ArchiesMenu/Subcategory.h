//
//  Subcategory.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class CategoryEntity, Item;

@interface Subcategory : Entity

@property (nonatomic, retain) NSString * category_id;
@property (nonatomic, retain) NSString * addition_enable;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) CategoryEntity *category;
@end

@interface Subcategory (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
