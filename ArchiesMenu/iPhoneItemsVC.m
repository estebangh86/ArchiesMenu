//
//  ItemsVC.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "iPhoneItemsVC.h"

@interface iPhoneItemsVC ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation iPhoneItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.documentsDirectory = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] path];
    
    [self.categoryLabel setText:self.categoryTitle];
}

- (IBAction)backTouched:(id)sender {
    
    [self.navigationController popViewControllerWithFlipStyle:MPFlipStyleFlipDirectionBit(MPFlipStyleOrientationVertical)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    Subcategory *subcategory = [self.items objectAtIndex:section];
    
    return [subcategory.items count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Subcategory *subcategory = [self.items objectAtIndex:section];
    
    return subcategory.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    
    Subcategory *subcategory = [self.items objectAtIndex:indexPath.section];
    Item *item = [[subcategory.items allObjects] objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[self.documentsDirectory stringByAppendingPathComponent:item.img_path]];
    
    // Evita error al intentar cargar imágenes nulas
    if (image)
        [cell.imageViewCell setImage:image];
    
    [cell.label setText:item.name];
    [cell.textView setText:item.item_description];
    
    return cell;
}

@end
