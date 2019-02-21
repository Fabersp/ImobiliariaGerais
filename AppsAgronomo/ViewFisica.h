//
//  ViewFisica.h
//  AppsAgronomo
//
//  Created by Fabricio Padua on 11/10/2018.
//  Copyright © 2018 Fabricio Padua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import <UCZProgressView/UCZProgressView.h>

@interface ViewFisica : UIViewController {
    
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


@end
