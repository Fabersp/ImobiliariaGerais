//
//  vc_politicas.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 08/10/2018.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import "vc_politicas.h"
#import "SWRevealViewController.h"
#import <TSMessages/TSMessageView.h>

@interface vc_politicas ()

@end

@implementation vc_politicas

@synthesize ViewApper;
@synthesize ObjetoJson;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Loading];

    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    [self.navigationController.view addSubview:ViewApper];

    self.title = @"Políticas e Privacidades";

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController ) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
        
        self.progressView = [[UCZProgressView alloc] initWithFrame:self.view.bounds];
        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.progressView];
        
        self.progressView.indeterminate = YES;
       // self.progressView.tintColor = vcCor;
        
        self.progressView.radius = 40.0;
        
        self.progressView.lineWidth = 6.0;
    
        NSURL * url = [NSURL URLWithString:@"http://www.promastersolution.com.br/guia/api/listar_paramentros.php?tipo_os=IOS&grupo=POLITICA_PRIVACIDADE&nome=MOBILE"];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSError * parseError = nil;
                news = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // Carregar os retorno do new //
                    int altura = ((int)[[UIScreen mainScreen] nativeBounds].size.height);
                    int largura = ((int)[[UIScreen mainScreen] nativeBounds].size.width);
                    
                    UIWebView * webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, altura,largura)];
                    NSString *url= [[news objectAtIndex:0] objectForKey:@"valor_param"];
                    NSURL *nsurl=[NSURL URLWithString:url];
                    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
                    [webview loadRequest:nsrequest];
                    [self.view addSubview:webview];
                    [self.progressView removeFromSuperview];
                    
                });
            }
        }];
        [task resume];
    }
}








@end
