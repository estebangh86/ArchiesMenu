//
//  iPadItemsVC.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "iPadItemsVC.h"

@interface iPadItemsVC ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation iPadItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.documentsDirectory = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] path];
    
    [self.categoryLabel setText:self.categoryTitle];
}

- (IBAction)backTouched:(id)sender {
    
    [self.navigationController popViewControllerWithFlipStyle:MPFlipStyleFlipDirectionBit(MPFlipStyleDefault)];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [self.items count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    Subcategory *subcategory = [self.items objectAtIndex:section];
    
    return [subcategory.items count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    
    Subcategory *subcategory = [self.items objectAtIndex:indexPath.section];
    
    [headerView.label setText:subcategory.name];
    
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    Subcategory *subcategory = [self.items objectAtIndex:indexPath.section];
    Item *item = [[subcategory.items allObjects] objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[self.documentsDirectory stringByAppendingPathComponent:item.img_path]];
    
    // Evita error al intentar cargar imágenes nulas
    if (image)
        [cell.imageView setImage:image];
    
    [cell.label setText:item.name];
    [cell.textView setText:item.item_description];
    
    return cell;
}

@end
