//
//  ViewController.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "ViewController.h"
#import "JSONManager.h"
#import "EventDetailsViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, JSONManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSArray *responseJSON;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    EventDetailsViewController *vc = (EventDetailsViewController *)[segue destinationViewController];
    vc.title = sender.textLabel.text;
    vc.eventDetails = sender.jsonCellAttribute;
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
    
    NSDictionary *venue = [[self.responseJSON objectAtIndex:indexPath.row] objectForKey:@"venue"];;
    
    cell.jsonCellAttribute = [self.responseJSON objectAtIndex:indexPath.row];
    
    if ([((NSString*) [venue objectForKey:@"name"]) length] != 0 ){
        cell.textLabel.text = [venue objectForKey:@"name"];
        cell.detailTextLabel.text = [venue objectForKey:@"address_1"];
    } else {
        cell.textLabel.text = @"N/A";
        cell.detailTextLabel.text = @"N/A";
    }

    
    return cell;
}

@end
