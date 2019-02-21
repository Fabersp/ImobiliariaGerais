//
//  ViewPesquisa.m
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/16.
//  Copyright © 2016 Fabricio Padua. All rights reserved.
//

#import "ViewPesquisa.h"
#import "SWRevealViewController.h"
#import "BuscarProprietarioTable.h"
#import "TableResultado.h"


#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface ViewPesquisa () 


@end

@implementation ViewPesquisa

@synthesize ViewApper;
@synthesize lbTipoImovel;
@synthesize lbcidade;
@synthesize lbBairro;
@synthesize lboperacao;
@synthesize btnFinalidade;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.valorMinimo.mask = @"#.###.###,##";
    self.valorMinimo.placeholder = @"R$ 0,00";
    
    self.valorMaximo.mask = @"#.###.###,##";
    self.valorMaximo.placeholder = @"R$ @####0,00";

    self.title = @"Filtrar";

    CorToolBar  = [UIColor colorWithRed:202/255.0 green:52/255.0 blue:35/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = CorToolBar;

    //branco botoes do navegador
    self.navigationController.navigationBar.tintColor = Rgb2UIColor(255,255,255);
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:Rgb2UIColor(255, 255, 255)}];
    
    btnFinalidade.tintColor = CorToolBar;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    VMaskTextField * maskTextField = (VMaskTextField*) textField;
    return  [maskTextField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lb_limpar:(id)sender {
    // limpar tudo o filtro //
    lbTipoImovel.text = @"indiferente";
    lbcidade.text = @"TODAS";
    // lbBairro.text = @"indiferente";
    lboperacao.text = @"indiferente";
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Index selected: %li", (long)indexPath.row);
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"operacao"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"operacao";
        destViewController.TipoImovel = lboperacao;
        
    } else if ([[segue identifier] isEqualToString:@"tipoimovel"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"tipoimovel";
        destViewController.TipoImovel = lbTipoImovel;
        
    } else if ([[segue identifier] isEqualToString:@"cidade"]) {
        BuscarProprietarioTable * destViewController = segue.destinationViewController;
        destViewController.deOnde = @"cidade";
        destViewController.TipoImovel = lbcidade;
        
    } else if ([[segue identifier] isEqualToString:@"fitrar"]) {
        TableResultado * destViewController = segue.destinationViewController;
        destViewController.cidade = lbcidade.text;
        destViewController.tipo_Imovel = lbTipoImovel.text;
        destViewController.operacao = lboperacao.text;
    }
    
//    else if ([[segue identifier] isEqualToString:@"bairro"]) {
//        BuscarProprietarioTable * destViewController = segue.destinationViewController;
//        destViewController.deOnde = @"bairro";
//        destViewController.StrCidade = lbcidade.text;
//
//        destViewController.TipoImovel = lbBairro;
//    }
    
}


@end
