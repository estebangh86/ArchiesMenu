//
//  iPadCategoryVC.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "iPadCategoryVC.h"

@interface iPadCategoryVC ()

@property NSInteger selectedIndexRow;

@end

@implementation iPadCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.documentsDirectory = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] path];
}

- (IBAction)backTouched:(id)sender {
    
    [self.navigationController popViewControllerWithFlipStyle:MPFlipStyleFlipDirectionBit(MPFlipStyleDefault)];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    CategoryEntity *category = [self.items objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[self.documentsDirectory stringByAppendingPathComponent:category.img_path]];
    
    // Evita error al intentar cargar imágenes nulas
    if (image)
        [cell.imageView setImage:image];
    
    [cell.label setText:category.name];
    
    return cell;
}

// Se contiene temporalmente al usuario en caso de no tener las subcategorías e ítems

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryEntity *category = [self.items objectAtIndex:indexPath.item];
    
    if ([category.subcategories count]) {
        
        iPadItemsVC *itemsVC = (iPadItemsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"iPadItemsVC"];
        
        [itemsVC setItems:[category.subcategories allObjects]];
        [itemsVC setCategoryTitle:category.name];
        
        [self.navigationController pushViewController:itemsVC flipStyle:MPFlipStyleDefault];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No hay contenido"
                                                        message:@"El contenido no está listo, espera por favor"
                                                       delegate:nil
                                              cancelButtonTitle:@"Esperar"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
}

@end
