//
//  iPadItemsVC.h
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MPFlipTransition.h>
#import "Subcategory.h"
#import "Item.h"
#import "HeaderView.h"
#import "CollectionItemCell.h"

@interface iPadItemsVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSString *documentsDirectory;
@property (strong, nonatomic) NSString *categoryTitle;

@end
