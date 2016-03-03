//
//  ViewController.h
//  SqliteDB
//
//  Created by Pavankumar Arepu on 24/02/2016.
//  Copyright © 2016 ppam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *studentTV;

@end

