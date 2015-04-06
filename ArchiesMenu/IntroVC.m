//
//  IntroVC.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#import "IntroVC.h"

@interface IntroVC ()

@end

@implementation IntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(move) withObject:nil afterDelay:5];
}

- (void)move {
    
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"] animated:NO];
}

@end
