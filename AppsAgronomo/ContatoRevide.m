//
//  ContatoRevide.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 28/07/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ContatoRevide.h"
#import "Reachability.h"
#import "SWRevealViewController.h"
#import "Map.h"
#import <sys/utsname.h>

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@implementation ContatoRevide

@synthesize ViewApper;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    // [self.view addSubview:ViewApper];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    CorToolBar  = [UIColor colorWithRed:202/255.0 green:52/255.0 blue:35/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = CorToolBar;
    
    //branco botoes do navegador
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    
    [self localizar:@"Av. Sete de Setembro, 546, Centro - Divinópolis - Minas Gerais"];
   
}
-(void) localizar:(NSString *) Endereco {
    geocoder = [[CLGeocoder alloc] init];
    
    NSLog(@"%@", Endereco);
    
    [geocoder geocodeAddressString:Endereco completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        placemark = [placemarks objectAtIndex:0];
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"coordinate = (%f, %f)", coordinate.latitude, coordinate.longitude);
        
        //  -21.225784,-47.8374115
        MKCoordinateRegion region;
        region.center = [(CLCircularRegion *)placemark.region center];
        lat = coordinate.latitude;
        lng = coordinate.longitude;
        NSLog(@"Localização");
        
        CLLocationCoordinate2D zoomLocation;
        zoomLocation.latitude = lat;
        zoomLocation.longitude= lng;
        
        self.map.mapType = MKMapTypeStandard;
        self.map.showsUserLocation = YES;
        
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lng);
        myAnnotation.title = cinema;
        //myAnnotation.subtitle = onde;
        [self.map addAnnotation:myAnnotation];
        
        float spanX = 0.00725;
        float spanY = 0.00725;
        
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        [self.map setRegion:region animated:YES];
        
        
    }];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    //	[self dismissModalViewControllerAnimated:YES];
    [self becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}



- (IBAction)btnMap:(id)sender {
    NSString * Endereco = @"Av. Sete de Setembro, 546, Centro, Divinópolis - Minas Gerais";

    Map * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"1234"];
    
    vc.endereco = Endereco;
    vc.cinema = @"Gerais Imobiliária";
   
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)btnEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
       // [[mailer navigationBar] setTintColor:[UIColor whiteColor]];
        
        [mailer setSubject:@"Contato - Gerais Imobiliária - iOS"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"contatos@geraisimobiliaria.com.br", nil];
        [mailer setToRecipients:toRecipients];
        // only for iPad
        mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        [self presentViewController:mailer animated:YES completion:^{NSLog (@"Action Completed");}];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha"
                                                        message:@"Este dispositivo não suporta o envio de e-mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}
- (IBAction)btnFacebook:(id)sender {
    
    NSString * UrlFacebook = @"https://www.facebook.com/geraisimobiliaria/?fref=ts";
   
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]) {
    
        NSString * profileFacebook = [NSString stringWithFormat:@"fb://profile/%@", @"1440955119462835"];
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:profileFacebook]];
    }
    else {
                    
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UrlFacebook]];
    
    }
    
}

- (IBAction)btnInstagram:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/geraisimobiliaria/?hl=pt-br"]];
}

- (IBAction)btnHome:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.geraisimobiliaria.com.br/"]];
}

- (IBAction)btnTelefone:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:3732142255"]];
}




@end
