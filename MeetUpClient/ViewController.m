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
@property UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.jsonManager = [[JSONManager alloc]init ];
    self.jsonManager.delegate = self;
    [self.jsonManager makeRequest];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meetup"]];
    self.imageView.frame = self.view.frame;
    self.imageView.center = self.view.center;
    self.imageView.alpha = 1.0;
    
    [self.view addSubview:self.imageView];
    [self.view bringSubviewToFront:self.imageView];
    
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
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0.0;
    }];
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
