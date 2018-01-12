//
//  ViewControllerRaspadinha.h
//  Raspadinha
//
//  Created by Erico GT on 11/01/18.
//  Copyright © 2018 lordesire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBox.h"
#import "ScrapeCollectionViewCell.h"
#import "ScrathItem.h"
#import "AppDelegate.h"
#import "SCLAlertViewStyleKit.h"

@interface ViewControllerRaspadinha : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MDScratchImageViewDelegate>

@property(nonatomic, assign) float lineThickness;
@property(nonatomic, assign) bool forcePremium;

@end

//***************************************************************************************
//Neste modelo o usuário raspa partes individuais (cada view processo o toque individualmente)
//***************************************************************************************