//
//  EventDetailsViewController.m
//  MeetUpClient
//
//  Created by Alejandro Tami on 04/08/14.
//  Copyright (c) 2014 Alejandro Tami. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "WebViewController.h"

@interface EventDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *confirmedAttendants;
@property (weak, nonatomic) IBOutlet UILabel *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.groupName.text = (NSString*)[[self.eventDetails objectForKey:@"group"] objectForKey:@"name"];
    NSNumber * number = [self.eventDetails objectForKey:@"yes_rsvp_count"];
    self.confirmedAttendants.text = [[number stringValue] stringByAppendingString: self.confirmedAttendants.text];
    self.url.text = [self.eventDetails objectForKey:@"event_url"];
    [self.webView loadHTMLString:[self.eventDetails objectForKey:@"description"] baseURL:nil];
}

- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    
      [self performSegueWithIdentifier:@"ModalSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WebViewController *vc = [segue destinationViewController];
    vc.url = self.url.text;
}

- (IBAction)onCloseButtonTap:(UIStoryboardSegue*)sender {
}



@end
