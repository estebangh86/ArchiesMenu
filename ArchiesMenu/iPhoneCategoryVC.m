//
//  CategoryVC.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "iPhoneCategoryVC.h"

@interface iPhoneCategoryVC ()

@end

@implementation iPhoneCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.documentsDirectory = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] path];
}

- (IBAction)backTouched:(id)sender {
    
    [self.navigationController popViewControllerWithFlipStyle:MPFlipStyleFlipDirectionBit(MPFlipStyleOrientationVertical)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell"];
    
    CategoryEntity *category = [self.items objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[self.documentsDirectory stringByAppendingPathComponent:category.img_path]];
    
    // Evita error al intentar cargar imágenes nulas
    if (image)
        [cell.imageViewCell setImage:image];
    
    [cell.label setText:category.name];
    
    return cell;
}

// Se contiene temporalmente al usuario en caso de no tener las subcategorías e ítems

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryEntity *category = [self.items objectAtIndex:indexPath.row];
    
    if ([category.subcategories count]) {
        
        iPhoneItemsVC *itemsVC = (iPhoneItemsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"iPhoneItemsVC"];
        
        [itemsVC setItems:[category.subcategories allObjects]];
        [itemsVC setCategoryTitle:category.name];
        
        [self.navigationController pushViewController:itemsVC flipStyle:MPFlipStyleOrientationVertical];
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
