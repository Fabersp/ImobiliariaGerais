//
//  TableInicial.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 26/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "TableInicial.h"
#import "CellResultado.h"
#import "ViewResultado.h"
#import "SWRevealViewController.h"
#import "Reachability.h"

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface TableInicial ()

@end

@implementation TableInicial

@synthesize lista_Itens;
@synthesize ViewApper;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ViewApper setFrame:[[UIScreen mainScreen] bounds]];
    
    [self.navigationController.view addSubview:ViewApper];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    CorToolBar  = [UIColor colorWithRed:202/255.0 green:52/255.0 blue:35/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = CorToolBar;
    
    //branco botoes do navegador
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];

    NSString * UrlMontadada = @"http://www.promastersolution.com.br/x7890_IOS/imoveis/rejane/inicio_ios.php";
    
    NSString *escapedPath = [UrlMontadada stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"escapedPath: %@", escapedPath);
    

    
    self.title = @"Destaque";
    
    
    [self Loading:[NSURL URLWithString:escapedPath]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void) Loading:(NSURL *) urlLista {
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask * task =
    [session downloadTaskWithURL:urlLista completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData * jsonData = [[NSData alloc] initWithContentsOfURL:location];
        lista_Itens = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    }];
    [task resume];
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return lista_Itens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellResultado * cell = (CellResultado *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    NSURL * urlImage = [NSURL URLWithString:[[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"imagem"]];
    
    
    cell.img_resultado.image = [UIImage imageNamed:@"loading_materia"];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:urlImage completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    CellResultado * updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.img_resultado.image = image;
                });
            }
        }
    }];
    [task resume];
    
    cell.lb_valor.text = [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"valor"];
    
    NSString * tipo_e_oper = [NSString stringWithFormat:@"%@ - %@",
                              [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"nome_tipo"],
                              [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"nome_operacao"]] ;
    
    cell.lb_tipo.text  = tipo_e_oper;
    
    NSString * cidadeBairro = [NSString stringWithFormat:@"%@ - %@",
                               [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"municipio"],
                               [[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"bairro"]] ;
    
    cell.lb_cidade.text = cidadeBairro;
    cell.lb_codigo_anuncio.text = [NSString stringWithFormat:@"Código: %@",[[lista_Itens objectAtIndex:indexPath.row] objectForKey:@"id_galeria"]];
    
    //cell.lbDormitorio.text = @"Dormitório: 3";
    //cell.lbMetragem.text = @"256 m²";
    //cell.lb_vagas.text = @"Vagas: 2";
    
    
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ObjetoJson = [lista_Itens objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    
    NSString * id_galeria = [ObjetoJson objectForKey:@"id_galeria"];
    NSString * Str_Valor = [ObjetoJson objectForKey:@"valor"];
    
    NSString * Str_tipo_operaao = [NSString stringWithFormat:@"%@ - %@",
                                   [ObjetoJson objectForKey:@"nome_tipo"],
                                   [ObjetoJson objectForKey:@"nome_operacao"]] ;
    
    NSString * Str_municipio = [NSString stringWithFormat:@"%@ - %@",
                                [ObjetoJson objectForKey:@"municipio"],
                                [ObjetoJson objectForKey:@"bairro"]] ;
    
    NSString * Str_Endereco = [ObjetoJson objectForKey:@"endereco"];
    
    NSString * Str_Descricao = [ObjetoJson objectForKey:@"descricao_completa"];
    
    
    if ([[segue identifier] isEqualToString:@"ViewInicio"]) {
        ViewResultado * destViewController = segue.destinationViewController;
        
        destViewController.Id_Galeria = id_galeria;
        destViewController.Valor = Str_Valor;
        destViewController.Operacao = Str_tipo_operaao;
        destViewController.Municipio = Str_municipio;
        destViewController.Endereco = Str_Endereco;
        destViewController.Descricao_Completa = Str_Descricao;
        
    }
}


@end
