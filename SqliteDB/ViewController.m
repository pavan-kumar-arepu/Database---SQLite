//
//  ViewController.m
//  SqliteDB
//
//  Created by Pavankumar Arepu on 24/02/2016.
//  Copyright © 2016 ppam. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()
{
    NSMutableArray *dataArray;
    Model *model;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc]init];
    model = [Model sharedModel];
    
    [self retriveData];
    [self.studentTV reloadData];
    
    
    
    [model creatingDB];
   // [model validateLoinCredentials:@"kumar" andPassword:@"Ammu"];
    
        
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [self retriveData];
    [self.studentTV reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)retriveData{
    dataArray = [[Model sharedModel]fetchStudentData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row:%ld",(long)indexPath.row);
    
   UITableViewCell  *simpleTableCell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableCell"];
    
    NSDictionary *studentInfo = [dataArray objectAtIndex:indexPath.row];
    UILabel *nameLabel = (UILabel *)[simpleTableCell viewWithTag:100];
    nameLabel.text = [studentInfo objectForKey:@"name"];
    
    
    UILabel *courseLabel = (UILabel *)[simpleTableCell viewWithTag:200];
    courseLabel.text = [studentInfo objectForKey:@"course"];
    
    
    UILabel *durationLabel = (UILabel *)[simpleTableCell viewWithTag:300];
    durationLabel.text = [studentInfo objectForKey:@"duration"];
    
    return simpleTableCell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
