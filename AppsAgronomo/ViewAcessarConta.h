//
//  ViewAcessarConta.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 10/10/2018.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>
#import "VMaskTextField.h"

@interface ViewAcessarConta : UIViewController <UITextFieldDelegate>  {
    
    NSArray * news;
    NSDictionary * ObjetoJson;
    Reachability* internetReachable;
    Reachability* hostReachable;
    bool internetActive;
    bool hostActive;
    UIColor * CorToolBar;
    
    int tipoEmpresa;
    
}

@property (nonatomic, retain) NSDictionary * ObjetoJson;
@property (nonatomic) IBOutlet UCZProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *ViewApper;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segTipoPessoal;

@property (weak, nonatomic) IBOutlet UITextField *txPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnAcessar;

@property (weak, nonatomic) IBOutlet VMaskTextField *txCPFCNPJ;

- (IBAction)btnTipoPessoa:(id)sender;

@end
