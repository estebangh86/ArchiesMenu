//
//  Entity.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * img_path;
@property (nonatomic, retain) NSString * type_id;
@property (nonatomic, retain) NSString * enabled;
@property (nonatomic, retain) NSString * created_at;
@property (nonatomic, retain) NSString * updated_at;
@property (nonatomic, retain) NSString * id_entity;

@end
