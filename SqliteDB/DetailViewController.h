//
//  DetailViewController.h
//  SqliteDB
//
//  Created by Pavankumar Arepu on 26/02/2016.
//  Copyright © 2016 ppam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *courseTF;
@property (weak, nonatomic) IBOutlet UITextField *durataionTF;

@end
