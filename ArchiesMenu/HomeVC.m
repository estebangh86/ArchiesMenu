//
//  ViewController.m
//  ArchiesMenu
//
//  Created by Esteban Garcia Henao on 4/5/15.
//  Copyright (c) 2015 Esteban Garcia Henao. All rights reserved.
//

#define NUESTRO_MENU 1

#import "HomeVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)setup {
    
    [self addNetworkObserver];
    
    [self connect];
}

// Permite verificar si el modelo ya ha sido persistido en el dispositivo
// y crea la instacia de conexión para obtener las entidades

- (void)connect {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *persisted = [userDefaults stringForKey:@"persisted"];
    
    if (!persisted) {
        
        Connections *connection = [[Connections alloc] init];
        
        [connection getEntities];
    }
}

// Registro de monitor de estado de conexión en el centro de notificaciones

- (void)addNetworkObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(HTTPOperationDidFinish:)
                                                 name:AFNetworkingOperationDidFinishNotification
                                               object:nil];
}

// Monitor de conexiones con alerta de resultado de conexión

- (void)HTTPOperationDidFinish:(NSNotification *)notification {
    
    AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)[notification object];
    
    if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
        
        return;
    }
    
    if (operation.error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de conexión"
                                                        message:@"No hay conexión a Internet"
                                                       delegate:nil
                                              cancelButtonTitle:@"Esperar"
                                              otherButtonTitles:@"Reintentar", nil];
        
        [alert setDelegate:self];
        [alert show];
    }
}

// Se ofrecen al usuario dos opciones si no existe conexión por medio de una alerta

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex) {
        
        [self connect];
    }
    else {
        
        [self performSelector:@selector(connect) withObject:nil afterDelay:10];
    }
}

// Selector común para escoger las opciones del menu principal o home
// Se hace diferenciación de dispositivo para instanciar controladores
// Se contiene temporalmente al usuario en caso de no tener las categorías

- (IBAction)menuButtonTouched:(id)sender {
    
    if ([sender tag] == NUESTRO_MENU) {
        
        NSArray *categories = [CategoryEntity findAllSortedBy:@"id_entity" ascending:YES];
        
        if ([categories count]) {
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                
                iPhoneCategoryVC *categoryVC = (iPhoneCategoryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"iPhoneCategoryVC"];;
                
                [categoryVC setItems:categories];
                
                [self.navigationController pushViewController:categoryVC flipStyle:MPFlipStyleOrientationVertical];
            }
            else {
                
                iPadCategoryVC *categoryVC = (iPadCategoryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"iPadCategoryVC"];;
                
                [categoryVC setItems:categories];
                
                [self.navigationController pushViewController:categoryVC flipStyle:MPFlipStyleDefault];
            }
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
}

@end
