//
//  Persistance.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "Persistance.h"
#import "Connections.h"

@class Connections;

@implementation Persistance

- (id)init {
    
    self.documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    return self;
}

// Persiste con MagicalRecord en CoreData entidades de nivel uno y dos

- (void)persistEntities {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        for (NSDictionary *category in self.response) {
            
            CategoryEntity *createdCategory = [CategoryEntity importFromObject:category inContext:localContext];
            
            for (NSDictionary *subcategory in [category objectForKey:@"subcategory"])
                [createdCategory addSubcategoriesObject:[Subcategory importFromObject:subcategory inContext:localContext]];
        }
    } completion:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"Categories and subcategories saved");
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
}

// Persiste detalle de entidades en tercer nivel

- (void)persistDetails {
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        
        for (NSDictionary *subcategory in [self.response objectForKey:@"subcategory"]) {
            
            Subcategory *fetchedSubcategory = [Subcategory findFirstByAttribute:@"id_entity" withValue:[subcategory objectForKey:@"id"] inContext:localContext];
            
            for (NSDictionary *item in [subcategory objectForKey:@"items"])
                [fetchedSubcategory addItemsObject:[Item importFromObject:item inContext:localContext]];
        }
    } completion:^(BOOL success, NSError *error) {
        
        if (success) {
            NSLog(@"Items saved from category: %@", [self.response objectForKey:@"id"]);
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            [userDefaults setObject:@"yes" forKey:@"persisted"];
            
            [userDefaults synchronize];
            
            [self persistContent];
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
}

// Persiste recursos/contenido de las entidades identificadas con estos
// Hace uso del selector de clase de conexiones
// Usa siguiente selector para crear carpetas y archivos si no existen

- (void)persistContent {
    
    NSArray *categories = [CategoryEntity findAllSortedBy:@"id_entity" ascending:YES];
    
    for (CategoryEntity *category in categories) {
        
        if (category.img_path)
            [self setupFolders:category.img_path];
    }
    
    NSArray *items = [Item findAllSortedBy:@"id_entity" ascending:YES];
    
    for (Item *item in items) {
        
        if (item.img_path)
            [self setupFolders:item.img_path];
        
        if (item.left_img_path)
            [self setupFolders:item.left_img_path];
        
        if (item.right_img_path)
            [self setupFolders:item.right_img_path];
    }
}

- (void)setupFolders:(NSString *)path {
    
    NSURL *img_path = [self.documentsDirectory URLByAppendingPathComponent:path];
    NSURL *directory = [img_path URLByDeletingLastPathComponent];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[directory path]])
        [[NSFileManager defaultManager] createDirectoryAtURL:directory withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[img_path path]])
        [Connections getContent:path];
}

@end
