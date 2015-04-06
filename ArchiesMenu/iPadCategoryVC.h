//
//  iPadCategoryVC.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MPFlipTransition.h>
#import "iPadItemsVC.h"
#import "CategoryEntity.h"
#import "Subcategory.h"
#import "CollectionCategoryCell.h"

@interface iPadCategoryVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *documentsDirectory;

@end
