//
//  HomeViewController.h
//  Demo_Mehul
//
//  Created by Apple-PC on 12/15/14.
//  Copyright (c) 2014 Openxcell. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblMain;
@end
