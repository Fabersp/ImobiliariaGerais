//
//  ViewJuridica.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/2018.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "ViewJuridica.h"
#import "ViewAcessarConta.h"
#import <TSMessages/TSMessageView.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ViewJuridica ()

@end

@implementation ViewJuridica

@synthesize ViewApper;
@synthesize ObjetoJson;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CorToolBar  = [UIColor colorWithRed:202/255.0 green:52/255.0 blue:35/255.0 alpha:1];
    tipoEmpresa = 0;
    
    self.navigationController.navigationBar.barTintColor = CorToolBar;
    
    //branco botoes do navegador
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    
    self.title = @"Área do cliente";
}

//--------------- Verificar a internet -----------------//
-(void) viewWillAppear:(BOOL)animated {
    // check for internet connection
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    hostReachable = [Reachability reachabilityWithHostName:@"www.google.com"];
    [hostReachable startNotifier];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)MensagemErro{
    
    // Add a button inside the message
    [TSMessage showNotificationInViewController:self
                                          title:@"Sem conexão com a intenet"
                                       subtitle:nil
                                          image:nil
                                           type:TSMessageNotificationTypeError
                                       duration:10.0
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:^{
                                     NSLog(@"User tapped the button");
                                     
                                 }
                                     atPosition:TSMessageNotificationPositionTop
                           canBeDismissedByUser:YES];
}


-(void) checkNetworkStatus:(NSNotification *)notice {
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus) {
        case NotReachable: {
            [self MensagemErro];
            self->internetActive = NO;
            break;
        }
        case ReachableViaWiFi: {
            self->internetActive = YES;
            [self Loading];
            
            break;
        }
        case ReachableViaWWAN: {
            self->internetActive = YES;
            [self Loading];
            break;
        }
    }
}

-(void)Loading {
    if (internetActive){
        
        //        self.progressView = [[UCZProgressView alloc] initWithFrame:self.view.bounds];
        //        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        //        [self.view addSubview:self.progressView];
        //
        //        self.progressView.indeterminate = YES;
        //        self.progressView.tintColor = CorToolBar;
        //
        //        self.progressView.radius = 40.0;
        //
        //        self.progressView.lineWidth = 6.0;
        
        NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/guia/api/listar_paramentros.php?tipo_os=IOS&grupo=POLITICA_PRIVACIDADE&nome=MOBILE"];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError * parseError = nil;
                news = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                });
            }
        }];
        [task resume];
    }
}


@end
