//
//  DetailViewController.m
//  SqliteDB
//
//  Created by Pavankumar Arepu on 26/02/2016.
//  Copyright © 2016 ppam. All rights reserved.
//

#import "DetailViewController.h"
#import "Model.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    if (self.nameTF.text.length > 0 && self.courseTF.text.length > 0 && self.durataionTF.text.length > 0) {
        int result = [[Model sharedModel] insertStudentData:self.courseTF.text withName:self.nameTF.text withDuration:self.durataionTF.text];
        if (!result) {
            [self dismissViewControllerAnimated:YES completion:nil];

        }
        else{
            
        }
    }
    else{
        
    }

}
@end
