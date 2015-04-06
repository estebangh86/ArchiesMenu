//
//  ItemsVC.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MPFlipTransition.h>
#import "Subcategory.h"
#import "Item.h"
#import "TableItemCell.h"

@interface iPhoneItemsVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *categoryTitle;

@end
