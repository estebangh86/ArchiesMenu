//
//  Item.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Subcategory;

@interface Item : Entity

@property (nonatomic, retain) NSString * item_description;
@property (nonatomic, retain) NSString * left_img_path;
@property (nonatomic, retain) NSString * right_img_path;
@property (nonatomic, retain) NSString * subcategory_id;
@property (nonatomic, retain) Subcategory *subcategory;

@end
