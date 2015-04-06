//
//  CategoryEntity.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Subcategory;

@interface CategoryEntity : Entity

@property (nonatomic, retain) NSSet *subcategories;
@end

@interface CategoryEntity (CoreDataGeneratedAccessors)

- (void)addSubcategoriesObject:(Subcategory *)value;
- (void)removeSubcategoriesObject:(Subcategory *)value;
- (void)addSubcategories:(NSSet *)values;
- (void)removeSubcategories:(NSSet *)values;

@end
