//
//  ViewController.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "JSONManager.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, JSONManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSDictionary *responseJSON;
@property JSONManager *jsonManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jsonManager = [[JSONManager alloc]init ];
    self.jsonManager.delegate = self;
    [self.jsonManager makeRequest];

}

#pragma mark JSONManager Delegate
- (void) responseWithJSON:(NSDictionary *) json;
{
    self.responseJSON = [json objectForKey:@"results"];
    [self.tableView reloadData];
}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.responseJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *venue = [self.responseJSON objectForKey:@"venue"];
    
    cell.textLabel.text = [venue objectForKey:@"name"];
    cell.detailTextLabel.text = [venue objectForKey:@"address_1"];
    
    return cell;
}

@end
