//
//  CategoryVC.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MPFlipTransition.h>
#import "iPhoneItemsVC.h"
#import "CategoryEntity.h"
#import "Subcategory.h"
#import "TableCategoryCell.h"

@interface iPhoneCategoryVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *documentsDirectory;

@end
